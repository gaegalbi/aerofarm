package yj.capstone.aerofarm.dto;

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
    private String contents;
    private LocalDateTime modifiedDate;

    public PostDetailDto(Post post) {
        this.id = post.getId();
        this.title = post.getTitle();
        this.writer = post.getWriter().getNickname();
        this.views = post.getViews();
        this.contents = post.getContent().getContents();
        this.modifiedDate = post.getContent().getModifiedDate();
    }
}
