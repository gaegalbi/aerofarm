package yj.capstone.aerofarm.dto.response;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@Setter
public class CommentListResponseDto {
    private Long postId;
    private String content;
    private String createdDate;

    @QueryProjection
    public CommentListResponseDto(Long postId, String content, LocalDateTime createdDate) {
        this.postId = postId;
        this.content = content;
        this.createdDate = createdDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
    }
}
