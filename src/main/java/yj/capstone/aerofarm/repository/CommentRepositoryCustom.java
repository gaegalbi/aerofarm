package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.dto.CommentDto;
import yj.capstone.aerofarm.dto.response.CommentListResponseDto;

import java.util.List;

public interface CommentRepositoryCustom {

    Page<CommentDto> findCommentInfo(Post post, Pageable pageable);
    List<CommentDto> findAnswerCommentInfo(Post post);
    Integer findMaxGroupIdInfo();
    Long findAllCommentCount(Post post);

    Page<CommentListResponseDto> findMyComment(Long memberId, Pageable pageable);
}
