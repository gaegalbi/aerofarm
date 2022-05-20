package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
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
import yj.capstone.aerofarm.config.auth.dto.SessionUser;
import yj.capstone.aerofarm.controller.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.MemberRepository;

import javax.servlet.http.HttpSession;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional
public class OAuth2UserServiceImpl implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

    private final BCryptPasswordEncoder passwordEncoder;
    private final MemberRepository memberRepository;
    private final HttpSession httpSession;

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
        httpSession.setAttribute("user", new SessionUser(member)); // SessionUser (직렬화된 dto 클래스 사용)

        return new UserDetailsImpl(member, oAuth2User.getAttributes());
    }

    /**
     * 회원가입 시 기존 회원이 있으면 기존 회원의 정보를 그대로 받아오게 했음 (로그인만 되게)
     * 추후 필요 시 update 주석 해제
     * 가입 되있으나 인증이 안된 회원이 있을 시 해당 회원 삭제 후 등록
     */
    private Member saveOrUpdate(OAuthAttributes attributes) {
        if (memberRepository.existsByEmail(attributes.getEmail())) { // 자체 회원가입된 계정이 있는지 검사
            if (memberRepository.existsByEmailAndVerifyFalse(attributes.getEmail())) {
                memberRepository.deleteByEmail(attributes.getEmail());
                return saveOAuth2Member(attributes.toEntity());
            }
            Member member = memberRepository.findByEmail(attributes.getEmail()).orElseThrow(() -> new UsernameNotFoundException("해당되는 회원이 없습니다."));
//            member.update(attributes.getName(), attributes.getPicture());
            return member;
        }
        return saveOAuth2Member(attributes.toEntity());
    }

    public Member saveOAuth2Member(Member newMember) {
        newMember.changePassword(passwordEncoder.encode(UUID.randomUUID().toString().substring(0, 6)));
        if (memberRepository.existsByNickname(newMember.getNickname())) {
            String newNickname = duplicateNicknameChange(newMember.getNickname());
            newMember.changeNickname(newNickname);
        }
        return memberRepository.save(newMember);
    }

    private String duplicateNicknameChange(String nickname) {
        if (memberRepository.existsByNickname(nickname)) {
            return duplicateNicknameChange(nickname + (int) (Math.random() * 9999));
        }
        return nickname;
    }
}
