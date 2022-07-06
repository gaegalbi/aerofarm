package yj.capstone.aerofarm.controller;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@AutoConfigureMockMvc
@SpringBootTest
class PasswordResetControllerTest {

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
}