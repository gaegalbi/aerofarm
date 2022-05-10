package yj.capstone.aerofarm.domain.member;

import lombok.*;
import yj.capstone.aerofarm.controller.form.SaveMemberForm;
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
//    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String nickname;

    private String phoneNumber;

    private float score;

    private String picture;

    private String provider;

    /**
     * 양방향 연관관계에서 굳이 필요 없는데
     * 연습, 테스트 목적으로 작성
     */
    @Builder.Default
    @OneToMany(mappedBy = "member")
    private List<Address> addresses = new ArrayList<>();

    @Builder.Default
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<MemberRole> roles = new ArrayList<>();

    /*public static MemberBuilder builder() {
        return MemberBuilder();
    }*/

    @Builder(builderMethodName = "saveMemberFormBuilder", builderClassName = "SaveMemberFormBuilder")
    public Member(SaveMemberForm saveMemberForm) {
        this.email = saveMemberForm.getEmail();
        this.password = saveMemberForm.getPassword();
        this.nickname = saveMemberForm.getNickname();
        this.roles.add(new MemberRole(saveMemberForm.getRole(), this));
        this.phoneNumber = saveMemberForm.getPhoneNumber();
    }

    @Builder(builderClassName = "UserDetailRegister")
    public Member(String nickname, String password, String provider, String picture, String email, Role role) {
        this.nickname = nickname;
        this.password = password;
        this.picture = picture;
        this.email = email;
        this.provider = provider;
        this.roles.add(new MemberRole(role, this));
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

    protected Member() {

    }

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
}
