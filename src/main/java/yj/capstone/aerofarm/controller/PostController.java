package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public String community_detail(@AuthenticationPrincipal UserDetailsImpl userDetails, @PathVariable String category, @PathVariable Long boardId, Model model, @RequestParam(defaultValue = "1") Integer page) {
        Post post = postService.selectPost(boardId);
        PostDetailDto result = new PostDetailDto(post);

        if (page < 1) page = 1;

        Page<CommentDto> commentInfo = postService.findCommentInfo(post, page);
        PageableList<CommentDto> pageableList = new PageableList<>(commentInfo);

        List<PostLikeDto> postLikeInfo = postService.findLikeInfo(post.getId());
        List<Long> isSelect = postService.isMemberSelectInfo(userDetails.getMember(), boardId);

        if (postLikeInfo.size() == 0) postLikeInfo.add(new PostLikeDto(post.getId(), 0L));

        model.addAttribute("pageableList", pageableList);
        model.addAttribute("selectPost", result);
        model.addAttribute("selectPostCategory", category);
        model.addAttribute("postLikeInfo", postLikeInfo.get(0));
        model.addAttribute("isSelected", isSelect.size());

        return "/community/postingPage";
    }

    // 게시글 안에서 댓글쓰기
    @ResponseBody
    @PostMapping("/community/createComment")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createComment(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody CommentForm commentForm) {
        return postService.createComment(userDetails.getMember(), commentForm).getId();
    }

    // 글쓰기 페이지
    @GetMapping("/community/writing")
    public String community_writing() {

        return "/community/writingPage";
    }

    // 글쓰기 로직
    @ResponseBody
    @PostMapping("/community/createPost")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createPost(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostForm postForm) {
        return postService.createPost(userDetails.getMember(), postForm).getId();
    }

    // 좋아요 로직
    @ResponseBody
    @PostMapping("/community/createLike")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createLike(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostLikeDto postLikeDto) {
        return postService.createLike(userDetails.getMember(), postLikeDto).getId();
    }

    // 좋아요 취소 로직
    @ResponseBody
    @PostMapping("/community/deleteLike")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long deleteLike(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostLikeDto postLikeDto) {
        if (userDetails.getMember() == null) return null;
        postService.deleteLike(userDetails.getMember(), postLikeDto);
        return postLikeDto.getPostId();
    }
}
