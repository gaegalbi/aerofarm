package yj.capstone.aerofarm.dto.request;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DeviceSettingDto {
    private Long number;
    private int temperature;
    private int humidity;
    private int fertilizer;
    private boolean ledOn;
    private boolean fanOn;
    private boolean pumpOn;

    public DeviceSettingDto() {
    }

    @QueryProjection
    public DeviceSettingDto(Long number, int temperature, int humidity, int fertilizer, boolean ledOn, boolean fanOn, boolean pumpOn) {
        this.number = number;
        this.temperature = temperature;
        this.humidity = humidity;
        this.fertilizer = fertilizer;
        this.ledOn = ledOn;
        this.fanOn = fanOn;
        this.pumpOn = pumpOn;
    }
}
