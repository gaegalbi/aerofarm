package yj.capstone.aerofarm.dto.response;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.device.Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@Setter
public class DeviceMemberListResponseDto {

    private Long number;
    private String nickname;
    private String imageUrl;
    private String model;
    private String plant;
    private String createdDate;

    @QueryProjection
    public DeviceMemberListResponseDto(Long number, String nickname, String imageUrl, Model model, String plant, LocalDateTime createdDate) {
        this.number = number;
        this.nickname = nickname;
        this.imageUrl = imageUrl;
        this.model = model.getName();
        this.plant = plant;
        this.createdDate = createdDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
    }
}
