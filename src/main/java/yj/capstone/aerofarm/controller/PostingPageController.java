package yj.capstone.aerofarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PostingPageController {

    @GetMapping("/postingPage")
    public String community() {

        return "/community/postingPage";
    }
}
