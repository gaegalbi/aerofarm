package yj.capstone.aerofarm.dto.request;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;

@Getter
@Setter
public class DeviceRegisterRequestDto {

    @NotEmpty
    private String uuid;

    private String nickname;
}
