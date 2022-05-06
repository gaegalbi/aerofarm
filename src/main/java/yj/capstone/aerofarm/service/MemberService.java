package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.controller.form.SaveMemberForm;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.MemberRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class MemberService implements UserDetailsService {

    private final MemberRepository memberRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public boolean validateLogin(String email, String password) {
        return memberRepository.existsByEmailAndPwd(email,password);
    }

    public boolean duplicateEmailCheck(String email) {
        return memberRepository.existsByEmail(email);
    }

    public void signup(SaveMemberForm saveMemberForm) {
        saveMemberForm.setPhoneNumber(removeHyphenPhoneNumber(saveMemberForm.getPhoneNumber()));

        String password = saveMemberForm.getPassword();
        String newPassword = passwordEncoder.encode(password);
        saveMemberForm.setPassword(newPassword);

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

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        return memberRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException(email));
    }
}
