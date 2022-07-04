package yj.capstone.aerofarm.domain.device;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class DeviceStatus {

    private static final int MAX_TEMP = 40;
    private static final int MIN_TEMP = 0;
    private static final int MAX_HUMI = 100;
    private static final int MIN_HUMI = 0;
    private static final int MAX_BRIGHT = 100;
    private static final int MIN_BRIGHT = 0;
    private static final int MAX_FERT = 10; // TODO 분당 분사량 추후 변경 필
    private static final int MIN_FERT = 1; // TODO 분당 분사량 추후 변경 필

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

    private int brightness;

    public DeviceStatus(Device device) {
        this.device = device;
        this.temperature = 20;
        this.humidity = 50;
        this.fertilizer = 1;
        this.brightness =50;
    }

    public void setTemperature(int temperature) {
        if (temperature >= MAX_TEMP || temperature <= MIN_TEMP) {
            throw new IllegalArgumentException("설정 값이 범위를 초과했습니다.");
        }
        this.temperature = temperature;
    }

    public void setHumidity(int humidity) {
        if (humidity >= MAX_HUMI || humidity <= MIN_HUMI) {
            throw new IllegalArgumentException("설정 값이 범위를 초과했습니다.");
        }
        this.humidity = humidity;
    }

    public void setFertilizer(int fertilizer) {
        if (fertilizer >= MAX_FERT || fertilizer <= MIN_FERT) {
            throw new IllegalArgumentException("설정 값이 범위를 초과했습니다.");
        }
        this.fertilizer = fertilizer;
    }

    public void setBrightness(int brightness) {
        if (brightness >= MAX_BRIGHT || brightness <= MIN_BRIGHT) {
            throw new IllegalArgumentException("설정 값이 범위를 초과했습니다.");
        }
        this.brightness = brightness;
    }
}
