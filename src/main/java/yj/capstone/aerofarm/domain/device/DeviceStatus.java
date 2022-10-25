package yj.capstone.aerofarm.domain.device;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.dto.request.DeviceSettingDto;

import javax.persistence.*;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class DeviceStatus {

    private static final int MAX_TEMP = 36;
    private static final int MIN_TEMP = 20;
    private static final int MAX_HUMI = 100;
    private static final int MIN_HUMI = 0;
//    private static final int MAX_BRIGHT = 100;
//    private static final int MIN_BRIGHT = 0;
    private static final int MAX_FERT = 60; // TODO 분당 분사량 추후 변경 필
    private static final int MIN_FERT = 0; // TODO 분당 분사량 추후 변경 필

    @Id
    @JoinColumn(name="device_id")
    private Long id;

    @OneToOne
    @MapsId
    @JoinColumn(name="device_id")
    private Device device;

    private int temperature;

    private int humidity;

    /**
     * 양액의 경우 ml 단위로 할건지?
     * float 고려
     */
    private int fertilizer;

    /**
     * 220V LED 사용으로 세부 조절 불가
     * ON, OFF로 조절만 가능
     */
    private boolean ledOn;

    /**
     * 5V 0.14A 팬 사용
     */
    private boolean fanOn;

    private boolean pumpOn;

    public DeviceStatus(Device device) {
        this.device = device;
        this.temperature = 20;
        this.humidity = 50;
        this.fertilizer = 1;
        this.ledOn = false;
        this.fanOn = false;
        this.pumpOn = false;
    }

    public void setTemperature(int temperature) {
        if (temperature > MAX_TEMP || temperature < MIN_TEMP) {
            throw new IllegalArgumentException("설정 값이 범위를 초과했습니다.");
        }
        this.temperature = temperature;
    }

    public void setHumidity(int humidity) {
        if (humidity > MAX_HUMI || humidity < MIN_HUMI) {
            throw new IllegalArgumentException("설정 값이 범위를 초과했습니다.");
        }
        this.humidity = humidity;
    }

    public void setFertilizer(int fertilizer) {
        if (fertilizer > MAX_FERT || fertilizer < MIN_FERT) {
            throw new IllegalArgumentException("설정 값이 범위를 초과했습니다.");
        }
        this.fertilizer = fertilizer;
    }

    public void setLed(boolean bool) {
        this.ledOn = bool;
    }

    public void setFan(boolean fanOn) {
        this.fanOn = fanOn;
    }

    public void setPump(boolean pumpOn) {
        this.pumpOn = pumpOn;
    }

    public void update(DeviceSettingDto request) {
        this.setFertilizer(request.getFertilizer());
        this.setHumidity(request.getHumidity());
        this.setTemperature(request.getTemperature());
        this.setLed(request.isLedOn());
        this.setFan(request.isFanOn());
        this.setPump(request.isPumpOn());
    }
}
