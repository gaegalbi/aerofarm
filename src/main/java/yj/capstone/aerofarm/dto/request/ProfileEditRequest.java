package yj.capstone.aerofarm.dto.request;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

@Getter
@Setter
public class ProfileEditRequest {

    @NotBlank
    private String nickname;

    @Length(max = 5)
    @Pattern(regexp = "^$|^[가-힣]*$")
    private String name;

    private String picture;

    @Pattern(regexp = "^$|^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$", message = "올바른 전화번호를 입력해주세요.")
    private String phoneNumber;

    private String address1;
    private String address2;

    @Pattern(regexp = "^$|^[0-9-]*$", message = "올바른 우편번호를 입력해주세요.")
    @Length(max = 7, message = "올바른 우편번호를 입력해주세요.")
    private String zipcode;

    private String extraAddress;
}
