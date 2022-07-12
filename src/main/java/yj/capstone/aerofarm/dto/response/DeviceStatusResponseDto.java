package yj.capstone.aerofarm.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DeviceStatusResponseDto {
    private boolean online;
    private int temperature;
    private int humidity;
    private int brightness;
    private int fertilizer;
}
