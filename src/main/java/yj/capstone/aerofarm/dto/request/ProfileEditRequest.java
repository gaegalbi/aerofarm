package yj.capstone.aerofarm.dto.request;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
public class ProfileEditRequest {

    @NotBlank
    private String nickname;
    private String name;
    private String phoneNumber;
    private String address1;
    private String address2;
    private String zipcode;
    private String extraAddress;
}
