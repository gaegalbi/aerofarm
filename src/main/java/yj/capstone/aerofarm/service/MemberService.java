package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.member.ConfirmationToken;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.member.Provider;
import yj.capstone.aerofarm.dto.request.ProfileEditRequest;
import yj.capstone.aerofarm.dto.request.SignupRequest;
import yj.capstone.aerofarm.dto.response.MemberListResponseDto;
import yj.capstone.aerofarm.dto.response.OrderAddressResponseDto;
import yj.capstone.aerofarm.exception.DuplicateValueException;
import yj.capstone.aerofarm.exception.TokenExpiredException;
import yj.capstone.aerofarm.repository.MemberRepository;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberService {

    private final MemberRepository memberRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final ConfirmationTokenService confirmationTokenService;

    public boolean duplicateEmailCheck(String email) {
        return memberRepository.existsByEmail(email);
    }

    @Transactional
    public void signup(SignupRequest signupRequest) {
        signupRequest.setPassword(passwordEncoder.encode(signupRequest.getPassword()));

        Member member = Member.builder()
                .email(signupRequest.getEmail())
                .password(signupRequest.getPassword())
                .nickname(signupRequest.getNickname())
                .name(signupRequest.getName())
                .picture("/image/default-avatar.png")
                .provider(Provider.LOCAL)
                .verify(false)
                .build();

        confirmationTokenService.createEmailConfirmationToken(signupRequest.getEmail());
        memberRepository.save(member);
        log.info("New member created. email = {}", signupRequest.getEmail());
    }

    @Transactional(readOnly = true)
    public boolean duplicateNicknameCheck(String nickname) {
        return memberRepository.existsByNickname(nickname);
    }

    @Transactional(readOnly = true)
    public boolean duplicatePhoneNumberCheck(String phoneNumber) {
        return memberRepository.existsByPhoneNumber(phoneNumber);
    }

    @Transactional
    public void confirmEmail(String token) {
        ConfirmationToken findToken = confirmationTokenService.findByIdAndExpirationDateAfter(token);
        Member findMember = findByEmailAndVerifyFalse(findToken.getEmail());
        findMember.emailVerifiedSuccess();
    }

    @Transactional(readOnly = true)
    public boolean isNotVerified(String email) {
        return memberRepository.existsByEmailAndVerifyFalse(email);
    }

    @Transactional(readOnly = true)
    public Member findMember(String email) {
        return memberRepository.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException("해당 회원이 없습니다."));
    }

    @Transactional(readOnly = true)
    public Member findMember(Long memberId) {
        return memberRepository.findById(memberId).orElseThrow(() -> new UsernameNotFoundException("해당 회원이 없습니다."));
    }

    @Transactional
    public void deleteByEmail(String email) {
        log.info("Member is delete. email = {}", email);
        memberRepository.deleteByEmail(email);
    }

    @Transactional(readOnly = true)
    public Member findByEmailAndVerifyFalse(String email) {
        return memberRepository.findByEmailAndVerifyFalse(email).orElseThrow(() -> new TokenExpiredException("이미 인증된 회원 입니다!"));
    }

    public boolean verifyPassword(String inputPassword, String userPassword) {
        return passwordEncoder.matches(inputPassword, userPassword);
    }

    @Transactional
    public Member changePassword(String email, String password) {
        Member findMember = findMember(email);
        String encodePassword = passwordEncoder.encode(password);
        findMember.changePassword(encodePassword);
        return findMember;
    }

    @Transactional
    public Member editProfile(String email, ProfileEditRequest profileEditRequest) {
        Member member = findMember(email);
        if (!profileEditRequest.getNickname().equals(member.getNickname()) && memberRepository.existsByNickname(profileEditRequest.getNickname())) {
            throw new DuplicateValueException("해당 닉네임이 이미 존재합니다.");
        }
        member.editProfile(profileEditRequest);
        return member;
    }

    @Transactional
    public Page<MemberListResponseDto> findMemberList(Pageable pageable) {
        return memberRepository.findMemberList(pageable);
    }

    public OrderAddressResponseDto findMemberAddress(Long id) {
        return memberRepository.findMemberAddress(id);
    }
}
