package yj.capstone.aerofarm.domain.member;

import lombok.*;
import yj.capstone.aerofarm.domain.AddressInfo;
import yj.capstone.aerofarm.form.SaveMemberForm;
import yj.capstone.aerofarm.domain.BaseEntity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@AllArgsConstructor
public class Member extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String nickname;

    private String phoneNumber;

    private float score;

    private String picture;

    @Enumerated(EnumType.STRING)
    private Provider provider;

    // 이메일 인증 여부
    private boolean verify;

    private String name;

    @Embedded
    private AddressInfo addressInfo;


    /**
     * 양방향 연관관계에서 굳이 필요 없는데
     * 연습, 테스트 목적으로 작성
     */
    @Builder.Default
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Address> addresses = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MemberRole> roles = new ArrayList<>();

    /*public static MemberBuilder builder() {
        return MemberBuilder();
    }*/

    @Builder(builderMethodName = "saveMemberFormBuilder", builderClassName = "SaveMemberFormBuilder")
    public Member(SaveMemberForm saveMemberForm) {
        this.email = saveMemberForm.getEmail();
        this.password = saveMemberForm.getPassword();
        this.nickname = saveMemberForm.getNickname();
        this.roles.add(new MemberRole(Role.GUEST, this));
        this.provider = Provider.LOCAL;
        this.verify = false; // 로컬 회원가입 시 검증 기본값 false
        this.name = saveMemberForm.getName();
        this.picture = "image/default-avatar.png";
    }

    @Builder(builderClassName = "oAuth2Builder")
    public Member(String nickname, String password, Provider provider, String picture, String email) {
        this.nickname = nickname;
        this.password = password;
        this.picture = picture;
        this.email = email;
        this.provider = provider;
        this.roles.add(new MemberRole(Role.GUEST, this));
        this.verify = true; // Oauth2 회원가입 시 검증 기본값 true
    }

    /*@Builder(builderMethodName = "oauth2Register", builderClassName = "Oauth2Register")
    public Member(String nickname, String password, String email,String picture, String provider, String providerId, Role role) {
        this.nickname = nickname;
        this.password = password;
        this.email = email;
        this.picture = picture;
        this.provider = provider;
        this.providerId = providerId;
        this.roles.add(new MemberRole(role, this));
    }*/

    protected Member() {} // NoArgsConstructor

    public Member update(String name, String picture) {
        this.nickname = name;
        this.picture = picture;
        return this;
    }

    public void changeNickname(String nickname) {
        this.nickname = nickname;
    }

    public void changePassword(String password) {
        this.password = password;
    }

    public void emailVerifiedSuccess() {
        this.verify = true;
    }
}
