package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.config.auth.dto.SessionUser;
import yj.capstone.aerofarm.controller.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.MemberRepository;

import javax.servlet.http.HttpSession;

@Service
@Slf4j
@RequiredArgsConstructor
@Transactional
public class UserDetailsServiceImpl implements UserDetailsService {

    private final MemberRepository memberRepository;
    private final HttpSession httpSession;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException(email));
        httpSession.setAttribute("user", new SessionUser(member)); // SessionUser (직렬화된 dto 클래스 사용)
        log.info("{} has login.",member.getEmail());
        return new UserDetailsImpl(member);
    }
}
