package yj.capstone.aerofarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import yj.capstone.aerofarm.dto.PostDto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CommunityController {

    @GetMapping("/community")
    public String community(Model model) {

        List<PostDto> postDtos = new ArrayList<>();

        PostDto postDto = new PostDto();
        postDto.setId(1L);
        postDto.setTitle("Test");
        postDto.setWriter("QQC");
        postDto.setLikes(1);
        postDto.setViews(123);
        postDto.setLocalDateTime(LocalDateTime.now());

        postDtos.add(postDto);

        model.addAttribute("postDtos", postDtos);

        return "community/communityPage";
    }
}
