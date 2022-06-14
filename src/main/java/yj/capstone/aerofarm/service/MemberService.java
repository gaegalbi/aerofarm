package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.form.SaveMemberForm;
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

    public boolean duplicateEmailCheck(String email) {
        return memberRepository.existsByEmail(email);
    }

    public void signup(SaveMemberForm saveMemberForm) {
        saveMemberForm.setPassword(passwordEncoder.encode(saveMemberForm.getPassword()));

        Member member = Member.saveMemberFormBuilder()
                .saveMemberForm(saveMemberForm)
                .build();

        confirmationTokenService.createEmailConfirmationToken(saveMemberForm.getEmail());
        memberRepository.save(member);
        log.info("New member created. email = {}", saveMemberForm.getEmail());
    }

    public boolean duplicateNicknameCheck(String nickname) {
        return memberRepository.existsByNickname(nickname);
    }

    public boolean duplicatePhoneNumberCheck(String phoneNumber) {
        return memberRepository.existsByPhoneNumber(phoneNumber);
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
        log.info("Member is delete. email = {}", email);
        memberRepository.deleteByEmail(email);
    }

    public Member findByEmailAndVerifyFalse(String email) {
        return memberRepository.findByEmailAndVerifyFalse(email).orElseThrow(() -> new TokenExpiredException("이미 인증된 회원 입니다!"));
    }

    public boolean verifyPassword(String inputPassword, String userPassword) {
        return passwordEncoder.matches(inputPassword, userPassword);
    }

    public void changePassword(Member member, String password) {
        Member findMember = findMemberById(member.getId());
        String encodePassword = passwordEncoder.encode(password);
        member.changePassword(encodePassword);
        findMember.changePassword(encodePassword);
    }

    public Member findMemberById(Long memberId) {
        return memberRepository.findById(memberId).orElseThrow(() -> new UsernameNotFoundException("해당 회원이 없습니다."));
    }
}
