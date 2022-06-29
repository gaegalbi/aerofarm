package yj.capstone.aerofarm.dto.response;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.domain.board.PostFilter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@Setter
public class PostListResponseDto {

    private Long id;
    private String title;
    private String createdDate;
    private long likes;
    private int views;
    private String filter;
    private String category;

    @QueryProjection
    public PostListResponseDto(Long id, String title, LocalDateTime createdDate, long likes, int views, PostFilter filter, PostCategory category) {
        this.id = id;
        this.title = title;
        this.createdDate = createdDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
        this.likes = likes;
        this.views = views;
        this.filter = filter.getName();
        this.category = category.getName();
    }
}
