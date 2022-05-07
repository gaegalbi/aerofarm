package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import yj.capstone.aerofarm.controller.form.LoginForm;
import yj.capstone.aerofarm.controller.form.SaveMemberForm;
import yj.capstone.aerofarm.service.MemberService;

import javax.validation.Valid;
import java.security.Principal;

@Slf4j
@Controller
@RequiredArgsConstructor
public class LoginController {

    private final MemberService memberService;

    @GetMapping("/login")
    public String loginPage(LoginForm loginForm, Model model, Principal principal) {
        if (principal != null) {
            return "redirect:/";
        }
        model.addAttribute("loginForm", new LoginForm());
        return "/loginPage";
    }

    @PostMapping("/login")
    public String loginSumit(@Valid LoginForm loginForm, BindingResult bindingResult) {
        return "/loginPage";
    }

    @GetMapping("/signup")
    public String signup(Model model, Principal principal) {
        if (principal != null) {
            return "redirect:/";
        }
        model.addAttribute("saveMemberForm", new SaveMemberForm());
        return "/signupPage";
    }

    @PostMapping("/signup")
    public String signupSubmit(@Valid SaveMemberForm saveMemberForm, BindingResult bindingResult) {
        signupValidate(saveMemberForm, bindingResult);

        if (bindingResult.hasErrors()) {
            log.info("errors={} ", bindingResult);
            return "/signupPage";
        }

        memberService.signup(saveMemberForm);
        return "redirect:/login";
    }

    private void signupValidate(SaveMemberForm saveMemberForm, BindingResult bindingResult) {
        if (!saveMemberForm.getPassword().equals(saveMemberForm.getConfirmPassword())) {
            bindingResult.rejectValue("password","notMatch");
        }
        if (memberService.duplicateEmailCheck(saveMemberForm.getEmail())) {
            bindingResult.rejectValue("email", "duplicate");
        }
        if (memberService.duplicateNicknameCheck(saveMemberForm.getNickname())) {
            bindingResult.rejectValue("nickname", "duplicate");
        }
        if (memberService.duplicatePhoneNumberCheck(saveMemberForm.getPhoneNumber())) {
            bindingResult.rejectValue("phoneNumber", "duplicate");
        }
    }
}
