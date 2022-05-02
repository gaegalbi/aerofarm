package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.controller.form.SaveMemberForm;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.MemberRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService {

    private final MemberRepository memberRepository;

    public boolean validateLogin(String email, String password) {
        return memberRepository.existsByEmailAndPassword(email,password);
    }

    public boolean duplicateEmailCheck(String email) {
        return memberRepository.existsByEmail(email);
    }

    public void signup(SaveMemberForm saveMemberForm) {
        saveMemberForm.setPhoneNumber(removeHyphenPhoneNumber(saveMemberForm.getPhoneNumber()));
        Member member = Member.builder(saveMemberForm).build();
        memberRepository.save(member);
    }

    private String removeHyphenPhoneNumber(String phoneNumber) {
        return phoneNumber.replace("-", "");
    }

    public boolean duplicateNicknameCheck(String nickname) {
        return memberRepository.existsByNickname(nickname);
    }

    public boolean duplicatePhoneNumberCheck(String phoneNumber) {
        return memberRepository.existsByPhoneNumber(removeHyphenPhoneNumber(phoneNumber));
    }
}
