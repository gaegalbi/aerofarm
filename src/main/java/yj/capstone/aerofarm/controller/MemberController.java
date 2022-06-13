package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.MemberDto;
import yj.capstone.aerofarm.service.MemberService;

@Controller
@PreAuthorize("hasAnyAuthority('GUEST')")
@RequiredArgsConstructor
public class MemberController {

    @GetMapping("/memberInfo")
    public String memberInfo(Model model, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        Member member = userDetails.getMember();
        MemberDto memberDto = MemberDto.builder()
                .email(member.getEmail())
                .phoneNumber(member.getPhoneNumber())
                .name(member.getName())
                .picture(member.getPicture())
                .nickname(member.getNickname())
                .addressInfo(member.getAddressInfo())
                .build();

        model.addAttribute("memberDto", memberDto);
        return "member/memberInfo";
    }
}
