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
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder(builderMethodName = "MemberBuilder")
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

    @Enumerated(EnumType.STRING)
    private Grade grade;

    private String phoneNumber;

    private float score;

    private String profileImage;

    /**
     * 양방향 연관관계에서 굳이 필요 없는데
     * 연습, 테스트 목적으로 작성
     */
    @Builder.Default
    @OneToMany(mappedBy = "member")
    private List<Address> addresses = new ArrayList<>();

    public static MemberBuilder builder(SaveMemberForm saveMemberForm) {
        return MemberBuilder()
                .email(saveMemberForm.getEmail())
                .password(saveMemberForm.getPassword())
                .phoneNumber(saveMemberForm.getPhoneNumber())
                .grade(saveMemberForm.getGrade())
                .nickname(saveMemberForm.getNickname());
    }
}
