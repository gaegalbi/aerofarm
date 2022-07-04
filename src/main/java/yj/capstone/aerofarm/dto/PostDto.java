package yj.capstone.aerofarm.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.domain.board.PostFilter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class PostDto {
    private Long id;
    private String title;
    private String writer;
    private PostCategory category;
    private PostFilter filter;
    private int views;
    private LocalDateTime modifiedDate;
    private Long commentCount;
    private Long likeCount;
    private Long parentId;
    private int groupId;
    private boolean deleteTnF;

    @Builder
    public PostDto(Post post) {
        this.id = post.getId();
        this.title = post.getTitle();
        this.writer = post.getWriter().getNickname();
        this.category = post.getCategory();
        this.views = post.getViews();
        this.modifiedDate = post.getCreatedDate();
    }

    @QueryProjection
    public PostDto(Long id, String title, String writer, PostCategory category, PostFilter filter, int views, LocalDateTime modifiedDate, Long commentCount, Long likeCount, Long parentId, int groupId, boolean deleteTnF) {
        this.id = id;
        this.title = title;
        this.writer = writer;
        this.category = category;
        this.filter = filter;
        this.views = views;
        this.modifiedDate = modifiedDate;
        this.commentCount = commentCount;
        this.likeCount = likeCount;
        this.parentId = parentId;
        this.groupId = groupId;
        this.deleteTnF = deleteTnF;
    }
}
