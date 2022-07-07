package yj.capstone.aerofarm.controller;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.dto.request.PhoneNumberRequestDto;
import yj.capstone.aerofarm.service.MessageService;

@RestController
@RequiredArgsConstructor
public class MessageController {

    private final MessageService messageService;


    /**
     * 단일 메시지 발송 예제
     */
    @PostMapping("/api/auth/sms")
    public String sendOne(@RequestBody PhoneNumberRequestDto request) {
        return messageService.sendSms(request);
    }

    @PostMapping("/api/auth/get-token")
    public String getToken(@RequestBody PhoneNumberRequestDto request) {
        String token = messageService.getToken(request).getAuthNumber();
        System.out.println(token);
        return token;
    }
}
