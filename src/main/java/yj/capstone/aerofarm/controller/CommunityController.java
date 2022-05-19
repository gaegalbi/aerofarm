package yj.capstone.aerofarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommunityController {

    // 전체 게시판 글 목록
    @GetMapping("/community")
    public String community() {

        return "/community/communityPage";
    }

    @GetMapping("/community/free")
    public String community_free() {
        return "/community/free";
    }
    // /community/free 자유게시판 글 목록
    // /community/free/{boardId} 자유게시판 글 상세보기
    
}
