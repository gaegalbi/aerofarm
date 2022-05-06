package yj.capstone.aerofarm.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import yj.capstone.aerofarm.domain.member.Member;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(@AuthenticationPrincipal Member member, Model model) {
        if (member == null) {
            return "index";
        }
        model.addAttribute("nickname", member.getNickname());
        return "index";
    }
}
