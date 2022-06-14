package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.*;
import yj.capstone.aerofarm.form.CommentForm;
import yj.capstone.aerofarm.form.PostForm;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.service.PostService;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class PostController {
    private final PostService postService;

    // 게시판 글 목록
    @GetMapping("/community/{category}")
    public String community(@PathVariable String category, Model model, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "title") String searchCategory, @RequestParam(defaultValue = "%") String keyword) {

        if (page < 1) page = 1;

        PostCategory postCategory = PostCategory.findByLowerCase(category);
        Page<PostDto> postInfo = postService.findPostInfo(postCategory, searchCategory, keyword, page);
        PageableList<PostDto> pageableList = new PageableList<>(postInfo);

        model.addAttribute("pageableList", pageableList);
        model.addAttribute("selectCategory", postCategory);

        return "/community/communityPage";
    }

    // 게시물 보기 페이지
    @GetMapping("/community/{category}/{boardId}")
    public String community_detail(@AuthenticationPrincipal UserDetailsImpl userDetails, @PathVariable String category, @PathVariable Long boardId, Model model, @RequestParam(defaultValue = "1") Integer page) {
        if (page < 1) page = 1;

        postService.updateViews(boardId);           // 조회수 업데이트

        Post post = postService.selectPost(boardId);    // 선택한 게시물 찾기
        PostDetailDto result = new PostDetailDto(post); // 선택한 게시물 id로 상세 내용 가져오기

        Page<CommentDto> commentInfo = postService.findCommentInfo(post, page); // 게시물 id로 포함 댓글 검색
        PageableList<CommentDto> pageableList = new PageableList<>(commentInfo);    // 페이징
        List<PostLikeDto> postLikeInfo = postService.findLikeInfo(post.getId());

        Long userId = null;
        if (userDetails != null) userId = userDetails.getMember().getId();
        Long isSelect = postService.isMemberSelectInfo(userId, boardId);

        if (postLikeInfo.size() == 0) postLikeInfo.add(new PostLikeDto(post.getId(), 0L));

        model.addAttribute("pageableList", pageableList);
        model.addAttribute("selectPost", result);
        model.addAttribute("selectPostCategory", category);
        model.addAttribute("postLikeInfo", postLikeInfo.get(0));
        model.addAttribute("isSelected", isSelect);
        model.addAttribute("user", userId);

        return "/community/postingPage";
    }

    // 글쓰기 페이지
    @GetMapping("/writing")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public String community_writing(@RequestParam(required = false) Long postId, Model model) {

        if (postId != null) model.addAttribute("selectPostId", postId);
        return "/community/writingPage";
    }

    // 글쓰기 로직
    @ResponseBody
    @PostMapping("/createBasicPost")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createPost(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostForm postForm) {
        return postService.createBasicPost(userDetails.getMember(), postForm).getId();
    }

    // 답글 쓰기 로직
    @ResponseBody
    @PostMapping("/createAnswerPost/{postId}")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createAnswerPost(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostForm postForm, @PathVariable Long postId) {
        return postService.createAnswerPost(userDetails.getMember(), postForm, postId).getId();
    }

    // 게시글 안에서 댓글쓰기
    @ResponseBody
    @PostMapping("/createComment")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createComment(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody CommentForm commentForm) {
        return postService.createComment(userDetails.getMember(), commentForm).getId();
    }

    // 좋아요 로직
    @ResponseBody
    @PostMapping("/createLike")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createLike(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostLikeDto postLikeDto) {
        return postService.createLike(userDetails.getMember(), postLikeDto).getId();
    }

    // 좋아요 취소 로직
    @ResponseBody
    @PostMapping("/deleteLike")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long deleteLike(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostLikeDto postLikeDto) {
        if (userDetails.getMember() == null) return null;
        postService.deleteLike(userDetails.getMember(), postLikeDto);
        return postLikeDto.getPostId();
    }
}
