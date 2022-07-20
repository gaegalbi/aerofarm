package yj.capstone.aerofarm.controller.api;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.dto.ErrorResponse;
import yj.capstone.aerofarm.dto.Message;
import yj.capstone.aerofarm.dto.request.SignupRequest;
import yj.capstone.aerofarm.service.MemberService;

import javax.validation.Valid;

@RestController
@RequiredArgsConstructor
@Slf4j
public class SignupController {

    private final MemberService memberService;

    @PostMapping("/signup/api")
    public ResponseEntity<Message> requestSignup(@Valid @RequestBody SignupRequest signupRequest) {
        signupValid(signupRequest);
        memberService.signup(signupRequest);
        return ResponseEntity.ok()
                .body(Message.createMessage("이메일로 인증 링크가 전송됐습니다."));
    }

    private void signupValid(SignupRequest signupRequest) {
        if (!signupRequest.isPasswordMatch()) {
            throw new IllegalArgumentException("비밀번호가 맞지 않습니다.");
        }
        if (memberService.duplicateEmailCheck(signupRequest.getEmail())) {
            if (memberService.isNotVerified(signupRequest.getEmail())) {
                // 이미 가입했지만 이메일 인증을 하지 않았을 때
                log.info("Member is already exist but not verified. email = {}", signupRequest.getEmail());
                memberService.deleteByEmail(signupRequest.getEmail());
                return;
            }
            throw new IllegalArgumentException("이미 가입된 이메일 입니다.");
        }
        if (memberService.duplicateNicknameCheck(signupRequest.getNickname())) {
            throw new IllegalArgumentException("중복된 닉네임 입니다.");
        }
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(IllegalArgumentException.class)
    public ErrorResponse signupException(IllegalArgumentException e) {
        return new ErrorResponse(e.getMessage());
    }
}
