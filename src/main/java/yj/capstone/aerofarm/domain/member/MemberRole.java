package yj.capstone.aerofarm.domain.member;

import lombok.Getter;
import yj.capstone.aerofarm.domain.BaseEntity;

import javax.persistence.*;

@Entity
@Getter
public class MemberRole extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private Role role;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "member_id")
    private Member member;

    public MemberRole() {
    }

    public MemberRole(Role role, Member member) {
        this.role = role;
        this.member = member;
    }
}
