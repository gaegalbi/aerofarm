package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import yj.capstone.aerofarm.domain.member.PasswordResetToken;
import yj.capstone.aerofarm.dto.ErrorResponse;
import yj.capstone.aerofarm.dto.Message;
import yj.capstone.aerofarm.dto.request.PasswordResetRequest;
import yj.capstone.aerofarm.dto.response.PasswordResetForm;
import yj.capstone.aerofarm.exception.TokenExpiredException;
import yj.capstone.aerofarm.service.MemberService;
import yj.capstone.aerofarm.service.PasswordResetService;

import javax.validation.Valid;

import static yj.capstone.aerofarm.dto.Message.createMessage;

@Controller
@RequiredArgsConstructor
public class PasswordResetController {

    private final PasswordResetService passwordResetService;
    private final MemberService memberService;

    @GetMapping("/login/reset-password")
    public String resetPassword() {
        return "resetPasswordPage";
    }

    @PostMapping("/login/reset-password")
    @ResponseBody
    public ResponseEntity<Message> sendResetLink(@RequestBody @Valid PasswordResetRequest request) {
        passwordResetService.createPasswordResetToken(request.getEmail());
        return ResponseEntity.ok()
                .body(createMessage("해당 이메일로 인증 링크가 전송 되었습니다."));
    }

    @GetMapping("/login/reset-password/confirm-email")
    public String viewConfirmEmail(@RequestParam String token, Model model, RedirectAttributes attr) {
        if (passwordResetService.validateToken(token)) {
            model.addAttribute("passwordResetForm", new PasswordResetForm(token));
            return "changePasswordPage";
        }
        attr.addFlashAttribute("error", "인증 시간이 지났습니다. 다시 시도해주세요.");
        return "redirect:/login/reset-password";
    }

    @PostMapping("/login/reset-password/confirm-email")
    @ResponseBody
    public ResponseEntity<Message> changePassword(@RequestBody @Valid PasswordResetForm passwordResetForm) {
        if (!passwordResetForm.isPasswordMatch()) {
            throw new IllegalArgumentException("비밀번호가 맞지 않습니다.");
        }

        PasswordResetToken token = passwordResetService.getToken(passwordResetForm.getToken());
        memberService.changePassword(token.getEmail(), passwordResetForm.getPassword());

        return ResponseEntity.ok()
                .body(createMessage("비밀번호가 정상적으로 변경되었습니다."));
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(IllegalArgumentException.class)
    public ErrorResponse passwordNotMatch(IllegalArgumentException e) {
        ErrorResponse response = new ErrorResponse(e.getMessage());
        response.addValidation("password","비밀번호가 맞지 않습니다.");
        return response;
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(UsernameNotFoundException.class)
    public ErrorResponse usernameNotFound() {
        return new ErrorResponse("잘못된 요청입니다.");
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(TokenExpiredException.class)
    public ErrorResponse tokenExpired(TokenExpiredException e) {
        return new ErrorResponse(e.getMessage());
    }
}
