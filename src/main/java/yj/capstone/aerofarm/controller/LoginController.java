package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import yj.capstone.aerofarm.controller.form.LoginForm;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.exception.LoginFailException;
import yj.capstone.aerofarm.service.MemberService;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final MemberService memberService;

    @GetMapping("/login")
    public String loginPage(Model model) {
        model.addAttribute("loginForm", new LoginForm());
        return "loginPage";
    }

    @PostMapping("/login")
    public String loginSumit(LoginForm loginForm) {
        if (!memberService.validateLogin(loginForm.getEmail(), loginForm.getPassword())) {
            throw new LoginFailException("해당 되는 계정이 없거나 비밀번호가 올바르지 않습니다.");
        }
        return "redirect:/";
    }
}
