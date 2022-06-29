package yj.capstone.aerofarm.repository;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.request.SignupRequest;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@Transactional
class MemberRepositoryTest {

    @Autowired
    MemberRepository memberRepository;

    @Test
    @DisplayName("회원 저장")
    void saveMemberTest() {
        SignupRequest signupRequest = new SignupRequest();
        signupRequest.setEmail("abc123@naver.com");
        signupRequest.setPassword("1234");
        signupRequest.setNickname("qqc");
        signupRequest.setName("홍길동");
        Member member = Member.builder()
                .email(signupRequest.getEmail())
                .password(signupRequest.getPassword())
                .nickname(signupRequest.getNickname())
                .name(signupRequest.getName())
                .build();

        memberRepository.save(member);

        Member findMember = memberRepository.findById(member.getId()).get();
        assertThat(member.getEmail()).isEqualTo(findMember.getEmail());
        assertThat(member.getNickname()).isEqualTo(findMember.getNickname());
        assertThat(member.getName()).isEqualTo(findMember.getName());
    }
}