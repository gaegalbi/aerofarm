package yj.capstone.aerofarm.dto.request;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DeviceConnInfoRequestDto {
    private String uuid;
    private String ipAddress;
    private String macAddress;
}
