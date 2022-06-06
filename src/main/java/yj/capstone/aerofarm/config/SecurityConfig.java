package yj.capstone.aerofarm.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import yj.capstone.aerofarm.domain.member.Role;
import yj.capstone.aerofarm.service.OAuth2UserServiceImpl;
import yj.capstone.aerofarm.service.UserDetailsServiceImpl;
import yj.capstone.aerofarm.service.handler.AuthFailureHandler;
import yj.capstone.aerofarm.service.handler.AuthSuccessHandler;

@EnableWebSecurity
@RequiredArgsConstructor
@EnableGlobalMethodSecurity(prePostEnabled = true,securedEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final UserDetailsServiceImpl userDetailsService;
    private final BCryptPasswordEncoder passwordEncoder;
    private final OAuth2UserServiceImpl OAuth2UserServiceImpl;
    private final AuthSuccessHandler authSuccessHandler;
    private final AuthFailureHandler authFailureHandler;

    private static final String[] ALLOW_LIST = {
            "/",
            "/login/**",
            "/signup/**",
            "/community",
            "/community/**", // TEST
            "/css/**",
            "/js/**",
            "/image/**",
            "/**" // TEST
    };

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
//                .csrf().disable()
                .headers().frameOptions().disable()
                .and()
                .authorizeRequests()
                .antMatchers(ALLOW_LIST).permitAll()
                .antMatchers("/api/v1/**").hasAnyAuthority(Role.MEMBER.name())
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .usernameParameter("email")
                .loginPage("/login")
                .successHandler(authSuccessHandler)
                .failureHandler(authFailureHandler)
                .permitAll()
                .and()
                .logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .logoutSuccessUrl("/")
                .permitAll()
                .and()
                .rememberMe()
                .alwaysRemember(false)
                .tokenValiditySeconds(43200)
                .rememberMeParameter("remember-me")
                .userDetailsService(userDetailsService)
                .and()
//                .sessionManagement()
//                .maximumSessions(1)
//                .maxSessionsPreventsLogin(true)
//                .expiredUrl("/login");
                .oauth2Login()
                .successHandler(authSuccessHandler)
                .loginPage("/login")
                .userInfoEndpoint()
                .userService(OAuth2UserServiceImpl);

//        super.configure(http);
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}
