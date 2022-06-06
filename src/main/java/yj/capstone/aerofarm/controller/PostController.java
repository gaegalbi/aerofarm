package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.controller.dto.*;
import yj.capstone.aerofarm.controller.form.PostForm;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.service.PostService;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class PostController {
    private final PostService postService;

    // 게시판 글 목록
    @GetMapping("/community/{category}")
    public String community(@PathVariable String category, Model model, @RequestParam(defaultValue = "1") Integer page) {

//        List<Post> posts = postService.findPosts(PostCategory.valueOf(category.toUpperCase()));
//        List<PostDto> result = posts.stream()
//                .map(o -> new PostDto(o))
//                .collect(Collectors.toList());
//
//        model.addAttribute("postDtos", result);

        if (page < 1) {
            page = 1;
        }
        
        Page<PostDto> postInfo = postService.findPostInfo(PostCategory.valueOf(category.toUpperCase()), page);
        PageableList<PostDto> pageableList = new PageableList<>(postInfo);
        model.addAttribute("pageableList", pageableList);

        return "/community/communityPage";
    }

    // 게시물 보기 페이지
    @GetMapping("/community/free/{boardId}")
    public String community_free(@PathVariable Long boardId, Model model) {
        Post post = postService.selectPost(boardId);
        PostDetailDto result = new PostDetailDto(post);

        model.addAttribute("selectPost", result);

        return "/community/postingPage";
    }

    // /community/free/{boardId} 자유게시판 글 상세보기


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
}
