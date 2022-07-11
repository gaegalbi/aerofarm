package yj.capstone.aerofarm.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DeviceIpUuidDto {
    private String uuid;
    private String ip;

    @QueryProjection
    public DeviceIpUuidDto(String uuid, String ip) {
        this.uuid = uuid;
        this.ip = ip;
    }
}
