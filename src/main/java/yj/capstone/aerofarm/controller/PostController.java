package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.board.*;
import yj.capstone.aerofarm.dto.*;
import yj.capstone.aerofarm.dto.response.CommentListResponseDto;
import yj.capstone.aerofarm.form.CommentForm;
import yj.capstone.aerofarm.form.PostForm;
import yj.capstone.aerofarm.service.PostService;

import javax.validation.Valid;
import java.util.List;

import static yj.capstone.aerofarm.dto.Message.*;

@Controller
@RequiredArgsConstructor
public class PostController {
    private final PostService postService;

    // 커뮤니티 메인 페이지
    @GetMapping("/community/{category}")
    public String community(@PathVariable String category, Model model, @PageableDefault Pageable pageable, @RequestParam(defaultValue = "title") String searchCategory, @RequestParam(defaultValue = "%") String keyword, @RequestParam(defaultValue = "all") String filter) {

        PostCategory postCategory = null;
        if (!category.equals("all")) {
            postCategory = PostCategory.findByLowerCase(category);     // 선택된 카테고리
        }
        PostFilter postFilter = null;
        if (!filter.equals("all")) {
            postFilter = PostFilter.findByLowerCase(filter);
        }
        Page<PostDto> postInfo = postService.findPostInfo(postCategory, searchCategory, keyword, postFilter, pageable);
        PageableList<PostDto> pageableList = new PageableList<>(postInfo);

        List<PostDto> answerPostInfo = postService.findAnswerPostInfo(postCategory, searchCategory, keyword, postFilter);

        model.addAttribute("pageableList", pageableList);       // 시초 게시글
        model.addAttribute("selectCategory", postCategory);     // 카테고리
        model.addAttribute("answerPostInfo", answerPostInfo);   // 답글 리스트

        return "community/communityPage";
    }

    // 인기 게시판 페이지
    @GetMapping("/hotcommunity/{category}")
    public String hotCommunity(@PathVariable String category, Model model, @PageableDefault Pageable pageable, @RequestParam(defaultValue = "title") String searchCategory, @RequestParam(defaultValue = "%") String keyword, @RequestParam(defaultValue = "all") String filter) {
        PostCategory postCategory = null;
        if (!category.equals("all")) {
            postCategory = PostCategory.findByLowerCase(category);     // 선택된 카테고리
        }
        PostFilter postFilter = null;
        if (!filter.equals("all")) {
            postFilter = PostFilter.findByLowerCase(filter);
        }
        Page<PostDto> hotPostInfo = postService.findHotPostInfo(postCategory, searchCategory, keyword, postFilter, pageable);
        PageableList<PostDto> pageableList = new PageableList<>(hotPostInfo);

        model.addAttribute("pageableList", pageableList);       // 시초 게시글
        model.addAttribute("selectCategory", postCategory);     // 카테고리

        return "community/hotCommunityPage";
    }

    // 본글 API
    @GetMapping("/api/community/posts")
    @ResponseBody
    public Page<PostDto> findPostApi(@RequestParam(required = false) String category, @RequestParam(defaultValue = "title") String searchCategory, @RequestParam(required = false) String keyword, @RequestParam(required = false) String filter, @PageableDefault Pageable pageable) {
        PostCategory postCategory = category == null ? null : PostCategory.findByLowerCase(category);
        PostFilter postFilter = filter == null ? null : PostFilter.findByLowerCase(filter);

        return postService.findPostInfo(postCategory, searchCategory, keyword, postFilter, pageable);
    }

    // 답글 API
    @GetMapping("/api/community/answerposts")
    @ResponseBody
    public List<PostDto> findAnswerPostApi(@RequestParam(required = false) String category, @RequestParam(defaultValue = "title") String searchCategory, @RequestParam(required = false) String keyword, @RequestParam(required = false) String filter) {
        PostCategory postCategory = category == null ? null : PostCategory.findByLowerCase(category);
        PostFilter postFilter = filter == null ? null : PostFilter.findByLowerCase(filter);

        return postService.findAnswerPostInfo(postCategory, searchCategory, keyword, postFilter);
    }

    // 본댓글 정보 API
    @GetMapping("/api/detail/comments")
    @ResponseBody
    public Page<CommentDto> findCommentApi(@RequestParam Long postId, @PageableDefault Pageable pageable) {
        return postService.findCommentInfo(postService.selectPost(postId), pageable);
    }

    // 댓글의 답글 정보 API
    @GetMapping("/api/detail/answercomments")
    @ResponseBody
    public List<CommentDto> findAnswerCommentApi(@RequestParam Long postId) {
        return postService.findAnswerCommentInfo(postService.selectPost(postId));
    }

    // 댓글 정보 API
    @GetMapping("/api/commentinfo")
    @ResponseBody
    public CommentDto findCommentInfo(@RequestParam Long commentId) {
        Comment comment = postService.selectComment(commentId);
        CommentDto commentDto = new CommentDto(comment);
        return commentDto;
    }

    // 게시글 좋아요 여부
    @GetMapping("/api/islike")
    @ResponseBody
    public boolean isLikePost(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestParam Long postId) {
        return postService.isMemberSelectInfo(userDetails.getMember().getId(), postId);
    }

    // 작성한 게시글 조회 API
    @GetMapping("/api/my/posts")
    @ResponseBody
    public Page<PostDto> findMyPostAllInfo(@AuthenticationPrincipal UserDetailsImpl userDetails, @PageableDefault Pageable pageable) {
        return postService.findMyPostsAllInfo(userDetails.getMember().getId(), pageable);
    }

    // 작성한 댓글 조회 API
    @GetMapping("/api/my/comments")
    @ResponseBody
    public Page<CommentListResponseDto> findMyComments(@AuthenticationPrincipal UserDetailsImpl userDetails, @PageableDefault Pageable pageable) {
        return postService.findMyCommentList(userDetails.getMember().getId(), pageable);
    }

    // 좋아요를 누른 게시글 조회
    @GetMapping("/api/my/likeposts")
    @ResponseBody
    public Page<PostDto> findMyLikePostInfo(@AuthenticationPrincipal UserDetailsImpl userDetails, @PageableDefault Pageable pageable) {
        return postService.findMyLikePostInfo(userDetails.getMember().getId(), pageable);
    }

    // 선택된 게시글 페이지
    @GetMapping("/community/detail/{postId}")
    public String community_detail(@AuthenticationPrincipal UserDetailsImpl userDetails, @PathVariable Long postId, Model model, @PageableDefault Pageable pageable) {
        postService.updateViews(postId);           // 조회수 업데이트

        Post post = postService.selectPost(postId);    // 선택한 게시물 찾기
        PostDetailDto result = new PostDetailDto(post); // 선택한 게시물 id로 상세 내용 가져오기

        Page<CommentDto> commentInfo = postService.findCommentInfo(post, pageable); // 게시물 id로 포함 댓글 검색
        PageableList<CommentDto> pageableList = new PageableList<>(commentInfo);    // 페이징
        List<PostLikeDto> postLikeInfo = postService.findLikeInfo(post.getId());

        List<CommentDto> answerCommentInfo = postService.findAnswerCommentInfo(post);

        Long userId = null;
        if (userDetails != null) {
            userId = userDetails.getMember().getId();
        }
        boolean isSelect = postService.isMemberSelectInfo(userId, postId);

        if (postLikeInfo.size() == 0) {
            postLikeInfo.add(new PostLikeDto(post.getId(), 0L));
        }

        model.addAttribute("commentCount", postService.commentCount(post));
        model.addAttribute("answerCommentInfo", answerCommentInfo);
        model.addAttribute("postInfo", post);
        model.addAttribute("pageableList", pageableList);
        model.addAttribute("selectPost", result);
        model.addAttribute("selectPostCategory", post.getCategory().getLowerCase());
        model.addAttribute("postLikeInfo", postLikeInfo.get(0));
        model.addAttribute("isSelected", isSelect);
        model.addAttribute("user", userId);

        return "community/postingPage";
    }

    // 글쓰기 페이지
    @GetMapping("/writing")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public String community_writing(@RequestParam(required = false) Long postId, @RequestParam(required = false) Long id, Model model) {

        PostForm postForm = new PostForm();
        Post post;
        if (postId != null) {               // 게시글의 답글
            post = postService.selectPost(postId);
            postForm.setPostId(postId);
            postForm.setCategory(post.getCategory().getLowerCase());
            postForm.setFilter(post.getFilter().getLowerCase());
            postForm.setTitle("Re:" + post.getTitle());
        } else if (id != null) {            // 게시글 수정
            post = postService.selectPost(id);
            postForm.setPostId(postId);
            postForm.setCategory(post.getCategory().getLowerCase());
            postForm.setFilter(post.getFilter().getLowerCase());
            postForm.setTitle(post.getTitle());
            postForm.setContents(post.getContent().getContents());
        }
        model.addAttribute("myId", id);
        model.addAttribute("selectPostId", postId);
        model.addAttribute("savePostForm", postForm);       // 아무 조건도 일치하지 않으면 새 글 작성
        return "community/writingPage";
    }

    /*--------------------------------------------------------------------------------------------------------------------------------------------------*/

    // 게시글 등록
    @ResponseBody
    @PostMapping("/createBasicPost")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public ResponseEntity<Message> createPost(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody @Valid PostForm postForm) {
        postService.createBasicPost(userDetails.getMember(), postForm);
        return ResponseEntity.ok()
                .body(createMessage("게시글 작성이 완료되었습니다."));
    }

    // 답글 등록
    @ResponseBody
    @PostMapping("/createAnswerPost")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public ResponseEntity<Message> createAnswerPost(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody @Valid PostForm postForm) {
        postService.createAnswerPost(userDetails.getMember(), postForm);
        return ResponseEntity.ok()
                .body(createMessage("답글 작성이 완료되었습니다."));
    }

    // 게시글 안에서 댓글 등록
    @ResponseBody
    @PostMapping("/createComment")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createComment(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody CommentForm commentForm) {
        return postService.createComment(userDetails.getMember(), commentForm).getId();
    }

    // 게시글 안에서 댓글의 답글 등록
    @ResponseBody
    @PostMapping("/createAnswerComment")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createAnswerComment(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody CommentForm commentForm) {
        return postService.createAnswerComment(userDetails.getMember(), commentForm).getId();
    }

    // 좋아요 등록
    @ResponseBody
    @PostMapping("/createLike")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long createLike(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostLikeDto postLikeDto) {
        return postService.createLike(userDetails.getMember(), postLikeDto).getId();
    }

    // 게시글 수정
    @ResponseBody
    @PostMapping("/updatePost")
    public ResponseEntity<Message> updatePost(@RequestBody @Valid PostForm postForm) {
        postService.updatePost(postForm);
        return ResponseEntity.ok()
                .body(createMessage("게시글 수정이 완료되었습니다."));
    }

    // 댓글 수정
    @ResponseBody
    @PostMapping("/updateComment")
    public Long updateComment(@RequestBody CommentForm commentForm) {
        return postService.updateComment(commentForm).getId();
    }

    // 게시글 삭제(soft)
    @ResponseBody
    @PostMapping("/deletePost")
    public Long deletePost(@RequestBody PostDto postDto) {
        postService.deletePost(postDto.getId());
        return postDto.getId();
    }

    // 댓글 삭제 (soft)
    @ResponseBody
    @PostMapping("/deleteComment")
    public Long deleteComment(@RequestBody CommentDto commentDto) {
        postService.deleteComment(commentDto.getId());
        return commentDto.getId();
    }

    // 좋아요 취소
    @ResponseBody
    @PostMapping("/deleteLike")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public Long deleteLike(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostLikeDto postLikeDto) {
        if (userDetails.getMember() == null) return null;
        postService.deleteLike(userDetails.getMember(), postLikeDto);
        return postLikeDto.getPostId();
    }
}
