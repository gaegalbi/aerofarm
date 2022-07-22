package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.dto.Message;
import yj.capstone.aerofarm.dto.request.AuthNumberRequestDto;
import yj.capstone.aerofarm.dto.request.PhoneNumberRequestDto;
import yj.capstone.aerofarm.service.MemberService;
import yj.capstone.aerofarm.service.MessageService;

import static yj.capstone.aerofarm.dto.Message.*;

@RestController
@RequiredArgsConstructor
@Slf4j
public class MessageController {

    private final MessageService messageService;

    private final MemberService memberService;


    /**
     * 단일 메시지 발송 예제
     */
    @PostMapping("/api/auth/sms")
    public String sendOne(@RequestBody PhoneNumberRequestDto request) {
        return messageService.sendSms(request);
    }

    @PostMapping("/api/auth/validate")
    public ResponseEntity<Message> validateToken(@RequestBody AuthNumberRequestDto request) {
        if (messageService.getToken(request.getAuthNumber())) {



            messageService.deleteToken(request.getAuthNumber());
            return ResponseEntity.ok().body(createMessage("인증 성공"));
        }
        return ResponseEntity.badRequest().body(createMessage("인증번호가 맞지 않습니다"));
    }

    @PostMapping("/api/auth/get-number")
    public ResponseEntity<Message> compareNumber(@RequestBody PhoneNumberRequestDto request) {
//        String phoneNumber = messageService.getNumber(request.getEmail());
        log.info("{}, {}", request.getEmail(), request.getPhoneNumber());

        if (memberService.isPhoneNumberMatch(request.getEmail(), request.getPhoneNumber())) {
            return ResponseEntity.ok().body(createMessage("ok"));
        }

        return ResponseEntity.badRequest().body(createMessage("회원 정보가 올바르지 않습니다."));
    }
}
