package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.member.ConfirmationToken;
import yj.capstone.aerofarm.exception.TokenExpiredException;
import yj.capstone.aerofarm.repository.ConfirmationTokenRepository;

import java.time.LocalDateTime;

@RequiredArgsConstructor
@Service
@Slf4j
public class ConfirmationTokenService {

    private final ConfirmationTokenRepository confirmationTokenRepository;
    private final EmailSenderService emailSenderService;

    public String createEmailConfirmationToken(String email) {
        ConfirmationToken token = getConfirmationToken(email);
        sendEmail(email, token);
        return token.getId();
    }

    @Transactional
    protected ConfirmationToken getConfirmationToken(String email) {
        ConfirmationToken token = ConfirmationToken.createEmailConfirmationToken(email);
        confirmationTokenRepository.save(token);
        return token;
    }

    protected void sendEmail(String email, ConfirmationToken emailConfirmationToken) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(email);
        mailMessage.setSubject("에어로팜 이메일 인증 요청");
        mailMessage.setText("http://localhost:8080/login/confirm-email?token=" + emailConfirmationToken.getId());
        emailSenderService.sendEmail(mailMessage);
        log.info("confirm signup email sent. by: {}", email);
    }

    @Transactional(readOnly = true)
    public ConfirmationToken findByIdAndExpirationDateAfter(String token) {
        return confirmationTokenRepository.findByIdAndExpirationDateAfter(token, LocalDateTime.now()).orElseThrow(
                () -> new TokenExpiredException("인증 시간이 만료 됐습니다. 다시 가입해주세요."));
    }

    @Transactional
    public void deleteByEmail(String email) {
        log.debug("Confirmation token is delete by email. Email: {}", email);
        confirmationTokenRepository.deleteByEmail(email);
    }
}
