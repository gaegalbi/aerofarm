package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.apache.tomcat.jni.Local;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import yj.capstone.aerofarm.domain.member.MessageAuthToken;
import yj.capstone.aerofarm.dto.request.PhoneNumberRequestDto;
import yj.capstone.aerofarm.exception.TokenExpiredException;
import yj.capstone.aerofarm.repository.MessageAuthRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;

@Service
@RequiredArgsConstructor
public class MessageService {

    private final DefaultMessageService defaultMessageService;

    private final MessageAuthRepository messageAuthRepository;


    public String sendSms(PhoneNumberRequestDto request) {
        Message message = new Message();

        MessageAuthToken token = MessageAuthToken.createMessageAuthToken(request.getPhoneNumber());
        messageAuthRepository.save(token);
        String authNumber = token.getAuthNumber();

        message.setFrom("01045611227");
        message.setTo(request.getPhoneNumber().replace("-",""));
        message.setText("[도시농부] 인증번호 [" + authNumber + "]를 입력해주세요.");

        defaultMessageService.sendOne(new SingleMessageSendingRequest(message));
        return authNumber;
    }

    public MessageAuthToken getToken(PhoneNumberRequestDto request) {
        return messageAuthRepository.findByPhoneNumber(request.getPhoneNumber()).orElseThrow(() -> new UsernameNotFoundException("해당 회원이 없습니다."));
    }
}
