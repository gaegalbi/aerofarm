package yj.capstone.aerofarm.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import yj.capstone.aerofarm.repository.PasswordResetTokenRepository;


@ExtendWith(MockitoExtension.class)
class PasswordResetServiceTest {

    PasswordResetService passwordResetService;

    @Mock
    EmailSenderService emailSenderService;

    @Mock
    PasswordResetTokenRepository passwordResetTokenRepository;

    @BeforeEach
    void setUp() {
        passwordResetService = new PasswordResetService(emailSenderService, passwordResetTokenRepository);
    }

    @Test
    void qqc() {
        String token = passwordResetService.createToken("qqc@qqc.com");
        System.out.println("token = " + token);
    }
}