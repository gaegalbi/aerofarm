package yj.capstone.aerofarm.dto.response;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DeviceInfoResponseDto {
    private Long number;
    private String nickname;
    private String createdDate;
    private String model;

    @QueryProjection
    public DeviceInfoResponseDto(Long number, String nickname, String createdDate, String model) {
        this.number = number;
        this.nickname = nickname;
        this.createdDate = createdDate;
        this.model = model;
    }
}
