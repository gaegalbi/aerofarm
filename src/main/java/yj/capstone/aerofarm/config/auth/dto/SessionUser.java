package yj.capstone.aerofarm.config.auth.dto;

import lombok.Getter;
import yj.capstone.aerofarm.domain.member.Member;

import java.io.Serializable;

@Getter
public class SessionUser implements Serializable {

    private String name;
    private String email;
    private String picture;

    public SessionUser(Member member) {
        this.name = member.getEmail();
        this.email = member.getEmail();
        this.picture = member.getPicture();
    }
}
