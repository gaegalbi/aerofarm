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

    @Enumerated(EnumType.STRING)
    private Role role;

    private String phoneNumber;

    private float score;

    private String picture;

    private String provider;
    private String providerId;

    /**
     * 양방향 연관관계에서 굳이 필요 없는데
     * 연습, 테스트 목적으로 작성
     */
    @Builder.Default
    @OneToMany(mappedBy = "member")
    private List<Address> addresses = new ArrayList<>();

    /*public static MemberBuilder builder() {
        return MemberBuilder();
    }*/

    @Builder(builderMethodName = "saveMemberFormBuilder", builderClassName = "SaveMemberFormBuilder")
    public Member(SaveMemberForm saveMemberForm) {
        this.email = saveMemberForm.getEmail();
        this.password = saveMemberForm.getPassword();
        this.nickname = saveMemberForm.getNickname();
        this.role = saveMemberForm.getRole();
        this.phoneNumber = saveMemberForm.getPhoneNumber();
    }

    @Builder(builderClassName = "UserDetailRegister")
    public Member(String nickname, String password,String picture, String email, Role role) {
        this.nickname = nickname;
        this.password = password;
        this.picture = picture;
        this.email = email;
        this.role = role;
    }

    @Builder(builderMethodName = "oauth2Register", builderClassName = "Oauth2Register")
    public Member(String nickname, String password, String email,String picture, Role role, String provider, String providerId) {
        this.nickname = nickname;
        this.password = password;
        this.email = email;
        this.picture = picture;
        this.role = role;
        this.provider = provider;
        this.providerId = providerId;
    }

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

    public String getRoleKey() {
        return this.role.getKey();
    }
}
