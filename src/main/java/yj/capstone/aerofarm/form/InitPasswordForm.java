package yj.capstone.aerofarm.form;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
public class InitPasswordForm {

    @NotBlank(message = "비밀번호를 입력해주세요.")
    private String password;
    @NotBlank(message = "비밀번호를 입력해주세요.")
    private String confirmPassword;

    public boolean isPasswordMatch() {
        return password.equals(confirmPassword);
    }
}
