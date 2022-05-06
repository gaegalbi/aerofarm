package yj.capstone.aerofarm.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import yj.capstone.aerofarm.controller.dto.MemberDto;
import yj.capstone.aerofarm.domain.member.Member;

@Controller
public class MemberController {

    @GetMapping("/memberInfo")
    public String memberInfo(Model model, @AuthenticationPrincipal Member member) {
        MemberDto memberDto = new MemberDto();
        memberDto.setEmail(member.getEmail());
        memberDto.setNickname(member.getNickname());

        model.addAttribute("memberDto", memberDto);

        return "member/memberInfo";
    }
}
