package yj.capstone.aerofarm.controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithAnonymousUser;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
class LoginControllerTest {

    @Autowired
    private WebApplicationContext context;

    MockMvc mvc;

    @BeforeEach
    public void setup() {
        mvc = MockMvcBuilders
                .webAppContextSetup(context)
                .apply(springSecurity())
                .build();
    }

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