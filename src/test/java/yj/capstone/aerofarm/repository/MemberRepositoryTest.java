package yj.capstone.aerofarm.repository;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import yj.capstone.aerofarm.form.SaveMemberForm;
import yj.capstone.aerofarm.domain.member.Member;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
class MemberRepositoryTest {

    @Autowired
    MemberRepository memberRepository;

    @Test
    @DisplayName("회원 저장")
    void saveMemberTest() {
        SaveMemberForm saveMemberForm = new SaveMemberForm();
        saveMemberForm.setEmail("abc123@naver.com");
        saveMemberForm.setPassword("1234");
        saveMemberForm.setPhoneNumber("010-1234-1234");
        saveMemberForm.setNickname("qqc");
        Member member = Member.saveMemberFormBuilder().saveMemberForm(saveMemberForm).build();

        memberRepository.save(member);

        Member findMember = memberRepository.findById(member.getId()).get();
        assertThat(member.getEmail()).isEqualTo(findMember.getEmail());
        assertThat(member.getNickname()).isEqualTo(findMember.getNickname());
        assertThat(member.getPhoneNumber()).isEqualTo(findMember.getPhoneNumber());
    }
}