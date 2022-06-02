package yj.capstone.aerofarm.controller.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import yj.capstone.aerofarm.domain.board.Post;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class PostDetailDto {
    private Long id;
    private String title;
    private String writer;
    private int views;
    private int likes;
    private String contents;
    private LocalDateTime localDateTime;

    public PostDetailDto(Post post) {
        this.id = post.getId();
        this.title = post.getTitle();
        this.writer = post.getWriter().getNickname();
        this.views = post.getViews();
        this.likes = post.getLikes();
        this.contents = post.getContent().getContents();
        this.localDateTime = post.getCreatedDate();
    }
}
