package yj.capstone.aerofarm.controller.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import yj.capstone.aerofarm.domain.board.File;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.domain.board.PostDetail;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class PostDto {
    private Long id;
    private String title;
    private String writer;
    private int views;
    private int likes;
    private LocalDateTime localDateTime;
    private PostDetail content;
    private List<File> files = new ArrayList<>();
    private PostCategory category;
    private Post parent;
    private List<Post> child = new ArrayList<>();

    @Builder
    public PostDto(PostDto postDto, PostDetail postDetail) {
        this.id = postDto.getId();
        this.title = postDto.getTitle();
        this.writer = postDto.getWriter();
        this.views = postDto.getViews();
        this.likes = postDto.getLikes();
        this.content = postDetail;

    }
}
