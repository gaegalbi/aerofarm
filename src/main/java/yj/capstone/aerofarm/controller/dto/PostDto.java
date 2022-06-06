package yj.capstone.aerofarm.controller.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class PostDto {
    private Long id;
    private String title;
    private String writer;
    private PostCategory category;
    private int views;
    private int likes;
    private LocalDateTime localDateTime;

    @Builder
    public PostDto(Post post) {
        this.id = post.getId();
        this.title = post.getTitle();
        this.writer = post.getWriter().getNickname();
        this.category = post.getCategory();
        this.views = post.getViews();
        this.likes = post.getLikes();
        this.localDateTime = post.getCreatedDate();
    }

    @QueryProjection
    public PostDto(Long id, String title, String writer, PostCategory category, int views, int likes, LocalDateTime localDateTime) {
        this.id = id;
        this.title = title;
        this.writer = writer;
        this.category = category;
        this.views = views;
        this.likes = likes;
        this.localDateTime = localDateTime;
    }
}
