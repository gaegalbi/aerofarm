package yj.capstone.aerofarm.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import yj.capstone.aerofarm.domain.board.Comment;
import yj.capstone.aerofarm.domain.board.Post;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class CommentDto {
    private Long id;
    private String writer;
    private LocalDateTime localDateTime;
    private String content;
    private Long postId;
    private Long writerId;
    private boolean deleteTnF;
    private int groupId;
    private String picture;

    @Builder
    public CommentDto(Comment comment) {
        this.id = comment.getId();
        this.writer = comment.getWriter().getNickname();
        this.localDateTime = comment.getCreatedDate();
        this.content = comment.getContent();
        this.postId = comment.getPost().getId();
        this.writerId = comment.getWriter().getId();
        this.deleteTnF = comment.isDeleteTnF();
        this.groupId = comment.getGroupId();
        this.picture = comment.getWriter().getPicture();
    }

    @QueryProjection
    public CommentDto(Long id, String writer, String content, LocalDateTime localDateTime, Post post, Long writerId, boolean deleteTnF, int groupId, String picture) {
        this.id = id;
        this.writer = writer;
        this.content = content;
        this.localDateTime = localDateTime;
        this.postId = post.getId();
        this.writerId = writerId;
        this.deleteTnF = deleteTnF;
        this.groupId = groupId;
        this.picture = picture;
    }
}
