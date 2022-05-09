package yj.capstone.aerofarm.controller.dto;

import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.member.Member;

@Setter
@Getter
public class MemberDto {

    private String email;
    private String nickname;
    private String picture;

    public void build(Member member) {
        this.email = member.getEmail();
        this.nickname = member.getNickname();
        this.picture = member.getPicture();
    }
}
