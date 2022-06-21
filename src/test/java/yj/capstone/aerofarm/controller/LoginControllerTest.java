package yj.capstone.aerofarm.controller;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithAnonymousUser;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@AutoConfigureMockMvc
@SpringBootTest
class LoginControllerTest {


    @Autowired
    private MockMvc mvc;

    @Test
    @WithAnonymousUser
    @DisplayName("로그인을 하지 않은 유저는 로그인 페이지로 이동 가능")
    void no_login_user_is_goto_login() throws Exception {
        mvc.perform(get("/login"))
                .andExpect(status().isOk());
//                .andDo(print());
    }

    @Test
    @WithMockUser
    @DisplayName("로그인을 한 유저는 로그인 페이지로 가면 메인페이지로 리다이렉션 된다.")
    void login_user_loginPage_must_goto_index() throws Exception {
        mvc.perform(get("/login"))
                .andExpect(status().is3xxRedirection());
//                .andDo(print());
    }

    @Test
    @WithAnonymousUser
    @DisplayName("로그인을 하지 않은 유저는 회원가입 페이지로 이동 가능")
    void no_login_user_is_goto_signup() throws Exception {
        mvc.perform(get("/login"))
                .andExpect(status().isOk());
//                .andDo(print());
    }

    @Test
    @WithMockUser
    @DisplayName("로그인을 한 유저는 회원가입 페이지로 가면 메인페이지로 리다이렉션 된다.")
    void login_user_signupPage_must_goto_index() throws Exception {
        mvc.perform(get("/login"))
                .andExpect(status().is3xxRedirection());
//                .andDo(print());
    }
}