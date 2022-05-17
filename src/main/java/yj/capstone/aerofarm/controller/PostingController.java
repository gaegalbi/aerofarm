package yj.capstone.aerofarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PostingController {

    @GetMapping("/posting")
    public String posting() {

        return "/community/postingPage";
    }
}
