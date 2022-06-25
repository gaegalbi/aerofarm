package yj.capstone.aerofarm.controller;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;
import yj.capstone.aerofarm.service.EmailSenderService;
import yj.capstone.aerofarm.service.PasswordResetService;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(MockitoExtension.class)
@AutoConfigureMockMvc
@SpringBootTest
class PasswordResetControllerTest {

    @MockBean
    EmailSenderService emailSenderService;

    @Autowired
    PasswordResetService passwordResetService;

    @Autowired
    MockMvc mvc;

    @Test
    @DisplayName("로그인하지 않은 유저는 비밀번호 찾기 페이지로 정상 이동해야 한다.")
    void without_loginUser_must_goto_passwordResetPage() throws Exception {
        // expected
        mvc.perform(get("/login/reset-password"))
                .andExpect(status().isOk());
    }
    
    @Test
    @DisplayName("잘못된 토큰으로 접속 시 리다이렉트 돼야한다.")
    void wrong_token_must_redirect() throws Exception {
        // expected
        mvc.perform(get("/login/reset-password/confirm-email?token=foo"))
                .andExpect(status().is3xxRedirection());
    }

    @Test
    @DisplayName("")
    void qqc() {
        // given
        String token = passwordResetService.createPasswordResetToken("mm8678@g.yju.ac.kr");
        // when
        System.out.println("token = " + token);
        // then

    }
    
}