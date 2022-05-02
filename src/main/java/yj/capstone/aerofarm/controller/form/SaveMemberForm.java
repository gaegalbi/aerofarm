package yj.capstone.aerofarm.controller.form;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;
import yj.capstone.aerofarm.domain.member.Grade;

import javax.validation.constraints.*;

@Getter
@Setter
public class SaveMemberForm {

    @NotBlank(message = "이메일을 입력해주세요.")
    @Email(message = "올바른 이메일 형식이 아닙니다.")
    private String email;

    @NotBlank(message = "비밀번호를 입력해주세요.")
    private String password;

    @NotBlank(message = "비밀번호를 입력해주세요.")
    private String confirmPassword;

    @NotBlank(message = "닉네임을 입력해주세요.")
    private String nickname;
    private final Grade grade = Grade.GUEST;

    @NotBlank(message = "전화번호를 입력해주세요.")
    @Pattern(regexp = "^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$", message = "올바른 전화번호를 입력해주세요.")
    private String phoneNumber;
}
