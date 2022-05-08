package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import yj.capstone.aerofarm.controller.dto.MemberDto;
import yj.capstone.aerofarm.controller.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.service.MemberService;

import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class HomeController {

    @GetMapping("/")
    public String home(Model model, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        MemberDto memberDto = new MemberDto();
        if (userDetails != null) {
            Member member = userDetails.getMember();
            memberDto.build(member);
        }
        model.addAttribute("memberDto", memberDto);
        return "index";
    }
}
