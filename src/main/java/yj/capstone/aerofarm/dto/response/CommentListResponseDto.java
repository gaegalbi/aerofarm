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
    private String title;
    private String content;
    private String createdDate;
    private boolean deleteTnF;

    @QueryProjection
    public CommentListResponseDto(Long postId, String title, String content, LocalDateTime createdDate, boolean deleteTnF) {
        this.postId = postId;
        this.title = title;
        this.content = content;
        this.createdDate = createdDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
        this.deleteTnF = deleteTnF;
    }
}
