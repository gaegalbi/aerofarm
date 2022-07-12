package yj.capstone.aerofarm.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DeviceSettingUuidDto {
    private String uuid;
    private int temperature;
    private int humidity;
    private int fertilizer;
    private boolean ledOn;

    public DeviceSettingUuidDto(String uuid, DeviceSettingDto deviceSettingDto) {
        this.uuid = uuid;
        this.temperature = deviceSettingDto.getTemperature();
        this.humidity = deviceSettingDto.getHumidity();
        this.fertilizer = deviceSettingDto.getFertilizer();
        this.ledOn = deviceSettingDto.isLedOn();
    }
}
