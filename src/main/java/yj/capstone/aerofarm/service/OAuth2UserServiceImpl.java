package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.config.auth.dto.OAuthAttributes;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.MemberRepository;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class OAuth2UserServiceImpl implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

    private final BCryptPasswordEncoder passwordEncoder;
    private final MemberRepository memberRepository;

    /**
     * 기존 회원이 있으면 기존 회원의 정보를 그대로 받아오게 했음 (로그인만 되게)
     * 추후 변경사항 생길 시 해당 옵션 제거 및 saveOrUpdate 메소드 주석 해제
     * 가입 되있으나 인증이 안된 회원이 있을 시 해당 회원 삭제 후 등록
     */
    @Override
    @Transactional
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
        OAuth2User oAuth2User = delegate.loadUser(userRequest);

        // OAuth2 서비스 id (구글, 카카오, 네이버)
        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        // OAuth2 로그인 진행 시 키가 되는 필드 값(PK)
        String userNameAttributeName = userRequest.getClientRegistration().getProviderDetails().getUserInfoEndpoint().getUserNameAttributeName();

        // OAuth2UserService
        OAuthAttributes attributes = OAuthAttributes.of(registrationId, userNameAttributeName, oAuth2User.getAttributes());

        Member member = saveOrUpdate(attributes);
        log.info("{} has login.",member.getEmail());
        return new UserDetailsImpl(member, oAuth2User.getAttributes());
    }

    /**
     * 회원가입 시 기존 회원이 있으면 기존 회원의 정보를 그대로 받아오게 했음 (로그인만 되게)
     * 추후 필요 시 update 주석 해제
     * 가입 되있으나 인증이 안된 회원이 있을 시 해당 회원 삭제 후 등록
     */
    private Member saveOrUpdate(OAuthAttributes attributes) {
        if (memberRepository.existsByEmailAndVerifyTrue(attributes.getEmail())) {
            Member member = memberRepository.findByEmail(attributes.getEmail()).orElseThrow(() -> new UsernameNotFoundException("해당되는 회원이 없습니다."));
//            member.update(attributes.getName(), attributes.getPicture());
            return member;
        }
        if (memberRepository.existsByEmailAndVerifyFalse(attributes.getEmail())) {
            log.debug("Member is already exist but not verified. Email: {}", attributes.getEmail());
            memberRepository.deleteByEmail(attributes.getEmail());
            log.debug("Member is delete by email. Email: {}", attributes.getEmail());
        }
        return saveOAuth2Member(attributes.toEntity());
    }

    public Member saveOAuth2Member(Member newMember) {
        String newNickname = duplicateNicknameChange(newMember.getNickname());
        newMember.changeNickname(newNickname);
        log.info("New member created. Email: {}", newMember.getEmail());
        return memberRepository.save(newMember);
    }

    private String duplicateNicknameChange(String nickname) {
        if (memberRepository.existsByNickname(nickname)) {
            String newNickname = nickname + (int) (Math.random() * 10);
            log.info("Nickname {} is duplicated. New nickname is {} ", nickname, newNickname);
            return duplicateNicknameChange(newNickname);
        }
        return nickname;
    }
}
