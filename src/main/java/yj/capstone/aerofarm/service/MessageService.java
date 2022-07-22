package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.member.MessageAuthToken;
import yj.capstone.aerofarm.dto.request.PhoneNumberRequestDto;
import yj.capstone.aerofarm.exception.AuthNumberNotFoundException;
import yj.capstone.aerofarm.repository.MessageAuthRepository;

@Service
@RequiredArgsConstructor
public class MessageService {

    private final DefaultMessageService defaultMessageService;

    private final MessageAuthRepository messageAuthRepository;

    @Transactional
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

    @Transactional(readOnly = true)
    public String getPhoneNumber(String authNumber) {
        MessageAuthToken token = messageAuthRepository.findByAuthNumber(authNumber)
                .orElseThrow(() -> new AuthNumberNotFoundException("해당 인증번호가 맞지 않습니다."));
        return token.getPhoneNumber();
    }

    @Transactional(readOnly = true)
    public boolean getToken(String authNumber) {
        return messageAuthRepository.existsByAuthNumber(authNumber);
    }

    @Transactional
    public void deleteToken(String authNumber) {
        messageAuthRepository.deleteByAuthNumber(authNumber);
    }

}
