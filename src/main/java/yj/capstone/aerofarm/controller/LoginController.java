package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import yj.capstone.aerofarm.dto.request.LoginRequest;
import yj.capstone.aerofarm.dto.request.SignupRequest;
import yj.capstone.aerofarm.exception.TokenExpiredException;
import yj.capstone.aerofarm.service.ConfirmationTokenService;
import yj.capstone.aerofarm.service.MemberService;

import javax.validation.Valid;
import java.security.Principal;

@Slf4j
@Controller
@RequiredArgsConstructor
public class LoginController {

    private final MemberService memberService;
    private final ConfirmationTokenService confirmationTokenService;

    @GetMapping("/login")
    public String loginPage(Model model, Principal principal) {
        if (principal != null) {
            return "redirect:/";
        }
        model.addAttribute("loginRequest", new LoginRequest());
        return "loginPage";
    }

    @PostMapping("/login")
    public String loginSumit(LoginRequest loginRequest) {
        return "loginPage";
    }

    @GetMapping("/login/confirm-email")
    public String viewConfirmEmail(@RequestParam String token, RedirectAttributes rttr) {
        try {
            memberService.confirmEmail(token);
        } catch (TokenExpiredException e) {
            rttr.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/login";
    }

    @GetMapping("/signup")
    public String signup(Model model, Principal principal) {
        if (principal != null) {
            return "redirect:/";
        }
        model.addAttribute("signupRequest", new SignupRequest());
        return "signupPage";
    }

    @PostMapping("/signup")
    public String signupSubmit(@Valid SignupRequest signupRequest, BindingResult bindingResult) {
        signupValidate(signupRequest, bindingResult);
        if (bindingResult.hasErrors()) {
            return "signupPage";
        }
        memberService.signup(signupRequest);
        return "redirect:/login";
    }

    private void signupValidate(SignupRequest signupRequest, BindingResult bindingResult) {
        log.debug("Duplicate member check. email = {}", signupRequest.getEmail());
        if (!signupRequest.isPasswordMatch()) {
            bindingResult.rejectValue("password", "notMatch");
        }
        if (memberService.duplicateEmailCheck(signupRequest.getEmail())) {
            if (memberService.isNotVerified(signupRequest.getEmail())) {
                // 이미 가입했지만 이메일 인증을 하지 않았을 때
                log.info("Member is already exist but not verified. email = {}", signupRequest.getEmail());
                confirmationTokenService.deleteByEmail(signupRequest.getEmail());
                memberService.deleteByEmail(signupRequest.getEmail());
                return;
            }
            bindingResult.rejectValue("email", "duplicate");
        }
        if (memberService.duplicateNicknameCheck(signupRequest.getNickname())) {
            bindingResult.rejectValue("nickname", "duplicate");
        }
    }
}
