package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import yj.capstone.aerofarm.dto.MemberDto;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;

@Controller
@RequiredArgsConstructor
public class HomeController {

    @GetMapping("/")
    public String home(Model model, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        if (userDetails != null) {
            Member member = userDetails.getMember();
            MemberDto memberDto = MemberDto.builder()
                    .nickname(member.getNickname())
                    .picture(member.getPicture())
                    .build();
            model.addAttribute("memberDto", memberDto);
        }
        return "index";
    }
}