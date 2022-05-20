package yj.capstone.aerofarm.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.controller.form.SaveMemberForm;

@SpringBootTest
@Transactional
class MemberRepositoryTest {

    @Autowired
    MemberRepository memberRepository;

    @Test
    void saveMemberTest() {
        SaveMemberForm saveMemberForm = new SaveMemberForm();
        saveMemberForm.setEmail("abc123@naver.com");
        saveMemberForm.setPassword("1234");
        saveMemberForm.setPhoneNumber("010-1234-1234");
        saveMemberForm.setNickname("qqc");

//        Member member = Member.builder(saveMemberForm).build();
//        memberRepository.save(member);

//        Member findMember = memberRepository.findById(member.getId()).orElseThrow(() -> {
//            throw new NoMemberFoundException("해당되는 멤버를 찾을 수 없습니다.");
//        });
//
//        assertThat(member.getEmail()).isEqualTo(findMember.getEmail());
//        assertThat(member.getNickname()).isEqualTo(findMember.getNickname());
//        assertThat(member.getPhoneNumber()).isEqualTo(findMember.getPhoneNumber());
    }

    @Test
    void loginValidateTest() {
        SaveMemberForm saveMemberForm = new SaveMemberForm();
        saveMemberForm.setEmail("abc123@naver.com");
        saveMemberForm.setPassword("1234");
        saveMemberForm.setPhoneNumber("010-1234-1234");
        saveMemberForm.setNickname("qqc");

//        Member member = Member.builder(saveMemberForm).build();
//        memberRepository.save(member);

//        boolean resultTrue = memberRepository.existsByEmailAndPwd("abc123@naver.com", "1234");
//        assertThat(resultTrue).isTrue();
//        boolean resultFalse = memberRepository.existsByEmailAndPwd("abc123@naver.com", "1111");
//        assertThat(resultFalse).isFalse();
    }
}