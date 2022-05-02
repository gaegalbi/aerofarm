package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.MemberRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {

    private final MemberRepository memberRepository;

    public Long save(Member member) {
        memberRepository.save(member);
        return member.getId();
    }

    public boolean validateLogin(String email, String password) {
        return memberRepository.existsByEmailAndPassword(email,password);
    }
}
