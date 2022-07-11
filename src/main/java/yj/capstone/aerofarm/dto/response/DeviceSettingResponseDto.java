package yj.capstone.aerofarm.dto.response;

import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.device.DeviceStatus;

@Getter
@Setter
public class DeviceSettingResponseDto {
    private int temperature;
    private int humidity;
    private int fertilizer;
    private boolean ledOn;

    private DeviceSettingResponseDto(int temperature, int humidity, int fertilizer, boolean ledOn) {
        this.temperature = temperature;
        this.humidity = humidity;
        this.fertilizer = fertilizer;
        this.ledOn = ledOn;
    }

    public static DeviceSettingResponseDto of(DeviceStatus deviceStatus) {
        return new DeviceSettingResponseDto(
                deviceStatus.getTemperature(),
                deviceStatus.getHumidity(),
                deviceStatus.getFertilizer(),
                deviceStatus.isLedOn()
        );
    }
}
