package yj.capstone.aerofarm.repository;

import com.querydsl.jpa.impl.JPAQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.dto.CommentDto;

public interface CommentRepositoryCustom {

    Page<CommentDto> findCommentInfo(Post post, Pageable pageable);
}
