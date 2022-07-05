package yj.capstone.aerofarm.dto.response;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.device.Model;

@Getter
@Setter
public class DeviceMemberListResponseDto {

    private String uuid;
    private String nickname;
    private String imageUrl;
    private String model;
    private String plant;

    @QueryProjection
    public DeviceMemberListResponseDto(String uuid, String nickname, String imageUrl, Model model, String plant) {
        this.uuid = uuid;
        this.nickname = nickname;
        this.imageUrl = imageUrl;
        this.model = model.getName();
        this.plant = plant;
    }
}
