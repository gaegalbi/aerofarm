package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.controller.form.SaveMemberForm;
import yj.capstone.aerofarm.domain.member.ConfirmationToken;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.exception.TokenExpiredException;
import yj.capstone.aerofarm.repository.MemberRepository;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class MemberService {

    private final MemberRepository memberRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final ConfirmationTokenService confirmationTokenService;

//    public boolean validateLogin(String email, String password) {
//        return memberRepository.existsByEmailAndPwd(email,password);
//    }

    public Member findByEmail(String email) {
        return memberRepository.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException(email));
    }

    public boolean duplicateEmailCheck(String email) {
        return memberRepository.existsByEmail(email);
    }

    public void signup(SaveMemberForm saveMemberForm) {
        saveMemberForm.setPhoneNumber(removeHyphenPhoneNumber(saveMemberForm.getPhoneNumber()));
        saveMemberForm.setPassword(passwordEncoder.encode(saveMemberForm.getPassword()));

        Member member = Member.saveMemberFormBuilder()
                .saveMemberForm(saveMemberForm)
                .build();
        confirmationTokenService.createEmailConfirmationToken(saveMemberForm.getEmail());
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

    public void confirmEmail(String token) {
        ConfirmationToken findToken = confirmationTokenService.findByIdAndExpirationDateAfter(token);
        Member findMember = findByEmailAndVerifyFalse(findToken.getEmail());
        findMember.emailVerifiedSuccess();
    }

    public boolean isNotVerified(String email) {
        return memberRepository.existsByEmailAndVerifyFalse(email);
    }

    public void deleteByEmail(String email) {
        log.debug("Member is delete by email. Email: {}", email);
        memberRepository.deleteByEmail(email);
    }

    public Member findByEmailAndVerifyFalse(String email) {
        return memberRepository.findByEmailAndVerifyFalse(email).orElseThrow(() -> new TokenExpiredException("이미 인증된 회원 입니다!"));
    }
}
