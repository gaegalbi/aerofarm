package yj.capstone.aerofarm.domain.device;

import javax.persistence.*;

@Entity
public class DeviceStatus {

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
}
