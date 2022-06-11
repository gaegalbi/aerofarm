package yj.capstone.aerofarm.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PostLikeDto {
    private Long postId;
    private Long likeCount;

    @QueryProjection
    public PostLikeDto(Long postId, Long likeCount) {
        this.postId = postId;
        this.likeCount = likeCount;
    }
}
