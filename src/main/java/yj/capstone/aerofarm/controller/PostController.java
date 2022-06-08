package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.dto.PageableList;
import yj.capstone.aerofarm.dto.PostDetailDto;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.dto.UserDetailsImpl;
import yj.capstone.aerofarm.form.PostForm;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.service.PostService;

@Controller
@RequiredArgsConstructor
public class PostController {
    private final PostService postService;

    // 게시판 글 목록
    @GetMapping("/community/{category}")
    public String community(@PathVariable String category, Model model, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "title") String searchCategory, @RequestParam(defaultValue = "%") String keyword) {

        if (page < 1) page = 1;

        PostCategory postCategory = PostCategory.findByLowerCase(category);
        System.out.println("postCategory = " + postCategory);
        Page<PostDto> postInfo = postService.findPostInfo(postCategory, searchCategory, keyword, page);
        PageableList<PostDto> pageableList = new PageableList<>(postInfo);
        model.addAttribute("pageableList", pageableList);

        model.addAttribute("selectCategory", postCategory);

        return "/community/communityPage";
    }

    // 게시물 보기 페이지
    @GetMapping("/community/{category}/{boardId}")
    public String community_detail(@PathVariable Long boardId, Model model) {
        Post post = postService.selectPost(boardId);
        PostDetailDto result = new PostDetailDto(post);

        model.addAttribute("selectPost", result);

        return "/community/postingPage";
    }

    // 글쓰기 페이지
    @GetMapping("/community/writing")
    public String community_writing() {

        return "/community/writingPage";
    }

    // 글쓰기 로직
    @ResponseBody
    @PostMapping("/community/createPost")
    @PreAuthorize("hasAnyAuthority('GUEST')") // 추후 해제 필요
    public Long createPost(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody PostForm postForm) {
        return postService.createPost(userDetails.getMember(), postForm).getId();
    }

}
