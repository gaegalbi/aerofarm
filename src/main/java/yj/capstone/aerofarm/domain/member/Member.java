package yj.capstone.aerofarm.domain.member;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.domain.BaseEntity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Member extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String email;

    private String password;

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
    @OneToMany(mappedBy = "member")
    private List<Address> addresses = new ArrayList<>();
}
