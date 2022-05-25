package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import yj.capstone.aerofarm.controller.dto.PostViewDto;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.service.CommunityService;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class CommunityController {
    private final CommunityService communityService;

    // 전체 게시판 글 목록
    @GetMapping("/community")
    public String community(Model model) {

        List<Post> posts = communityService.findPosts();
        List<PostViewDto> result = posts.stream()
                .map(o -> new PostViewDto(o))
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
}
