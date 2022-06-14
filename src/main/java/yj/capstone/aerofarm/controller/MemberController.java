package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.MemberDto;
import yj.capstone.aerofarm.dto.MyPageAuthDto;
import yj.capstone.aerofarm.form.InitPasswordForm;
import yj.capstone.aerofarm.service.MemberService;

import javax.validation.Valid;

@Controller
@PreAuthorize("hasAnyAuthority('GUEST')")
@RequiredArgsConstructor
@Slf4j
@SessionAttributes("verify")
public class MemberController {

    // TODO AOP 사용해서 인증 여부 관련 공통화 필요
    private final MemberService memberService;

    @ModelAttribute("verify")
    public MyPageAuthDto setMyPageSession() {
        return new MyPageAuthDto();
    }

    @GetMapping("/my-page/need-auth")
    public String loginCheckForm(@ModelAttribute("verify") MyPageAuthDto verify, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        if (!StringUtils.hasText(userDetails.getPassword())) {
            return "redirect:/my-page/init-password";
        }
        return "member/needAuthPage";
    }

    @PostMapping("/my-page/need-auth")
    public String loginAuth(@ModelAttribute("verify") MyPageAuthDto verify, String password, @AuthenticationPrincipal UserDetailsImpl userDetails, Model model) {
        boolean result = memberService.verifyPassword(password, userDetails.getPassword());
        if (result) {
            verify.setVerify(true);
            return "redirect:/my-page/info";
        }
        model.addAttribute("error", true);
        return "member/needAuthPage";
    }

    @GetMapping("/my-page/init-password")
    public String initPasswordForm(Model model) {
        model.addAttribute("initPasswordForm", new InitPasswordForm());
        return "member/initPasswordPage";
    }

    @PostMapping("/my-page/init-password")
    public String initPassword(@AuthenticationPrincipal UserDetailsImpl userDetails, @Valid InitPasswordForm initPasswordForm, BindingResult bindingResult) {
        if (!initPasswordForm.isPasswordMatch()) {
            bindingResult.rejectValue("password", "notMatch");
        }
        if (bindingResult.hasErrors()) {
            return "member/initPasswordPage";
        }

        memberService.changePassword(userDetails.getMember(), initPasswordForm.getPassword());
        return "redirect:/my-page/info";
    }

    @GetMapping("/my-page/info")
    public String memberInfo(@ModelAttribute("verify") MyPageAuthDto verify, Model model, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        if (!verify.getVerify()) {
            return "redirect:/my-page/need-auth";
        }

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

    // TODO 주문 목록 작성 필요!!!

}
