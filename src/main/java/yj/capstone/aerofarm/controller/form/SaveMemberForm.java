package yj.capstone.aerofarm.controller.form;

import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.member.Grade;

@Getter
@Setter
public class SaveMemberForm {
    private String email;
    private String password;
    private String nickname;
    private final Grade grade = Grade.GUEST;
    private String phoneNumber;
}
