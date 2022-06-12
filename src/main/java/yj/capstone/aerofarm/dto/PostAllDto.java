package yj.capstone.aerofarm.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import yj.capstone.aerofarm.domain.board.PostCategory;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class PostAllDto {
    private Long id;
    private String title;
    private String writer;
    private PostCategory category;
    private int views;
    private LocalDateTime localDateTime;
    private Long commentCount;
    private Long likeCount;

    @Builder
    public PostAllDto(Long id, String title, String writer, PostCategory category, int views, LocalDateTime localDateTime, Long commentCount, Long likeCount) {
        this.id = id;
        this.title = title;
        this.writer = writer;
        this.category = category;
        this.views = views;
        this.localDateTime = localDateTime;
        this.commentCount = commentCount;
        this.likeCount = likeCount;
    }
}