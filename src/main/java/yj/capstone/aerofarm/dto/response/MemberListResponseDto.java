package yj.capstone.aerofarm.dto.response;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
public class MemberListResponseDto {
    private Long id;
    private String email;
    private String nickname;
    private String createdDate;

    @QueryProjection
    public MemberListResponseDto(Long id, String email, String nickname, LocalDateTime createdDate) {
        this.id = id;
        this.email = email;
        this.nickname = nickname;
        this.createdDate = createdDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
    }
}
