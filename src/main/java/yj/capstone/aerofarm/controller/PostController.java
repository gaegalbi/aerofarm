package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import yj.capstone.aerofarm.controller.dto.PostDto;
import yj.capstone.aerofarm.controller.dto.UserDetailsImpl;
import yj.capstone.aerofarm.controller.form.PostForm;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.service.PostService;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class PostController {
    private final PostService postService;

    // 전체 게시판 글 목록
    @GetMapping("/community")
    public String community(Model model) {

        List<Post> posts = postService.findPosts();
        List<PostDto> result = posts.stream()
                .map(o -> new PostDto(o))
                .collect(Collectors.toList());

        model.addAttribute("postDtos", result);

        return "/community/communityPage";
    }

    @GetMapping("/community/free")
    public String community_free() {

        return "/community/postingPage";
    }
    // /community/free 자유게시판 글 목록
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
