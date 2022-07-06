package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.member.PasswordResetToken;
import yj.capstone.aerofarm.exception.TokenExpiredException;
import yj.capstone.aerofarm.repository.PasswordResetTokenRepository;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class PasswordResetService {

    private final EmailSenderService emailSenderService;
    private final PasswordResetTokenRepository passwordResetTokenRepository;

    @Transactional
    public String createPasswordResetToken(String email) {
        String token = createToken(email);
        sendEmail(email, token);
        return token;
    }

    protected void sendEmail(String email, String token) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        mailMessage.setTo(email);
        mailMessage.setSubject("에어로팜 비밀번호 재설정 요청");
        mailMessage.setText("http://localhost:8080/login/reset-password/confirm-email?token=" + token);
        emailSenderService.sendEmail(mailMessage);
        log.info("password reset email sent. by: {}", email);
    }

    protected String createToken(String email) {
        if (passwordResetTokenRepository.existsByEmail(email)) {
            passwordResetTokenRepository.deleteByEmail(email);
        }
        PasswordResetToken token = PasswordResetToken.createPasswordResetToken(email);
        passwordResetTokenRepository.save(token);
        return token.getId();
    }

    public boolean validateToken(String token) {
        return passwordResetTokenRepository.existsByIdAndExpirationDateAfter(token, LocalDateTime.now());
    }

    public PasswordResetToken getToken(String token) {
        return passwordResetTokenRepository.findByIdAndExpirationDateAfter(token, LocalDateTime.now())
                .orElseThrow(() -> new TokenExpiredException("인증 시간이 만료 됐습니다. 다시 가입해주세요."));
    }

}
