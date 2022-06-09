package yj.capstone.aerofarm.repository;

import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.dto.CommentDto;
import yj.capstone.aerofarm.dto.QCommentDto;

import java.util.List;

import static yj.capstone.aerofarm.domain.board.QComment.comment;

@RequiredArgsConstructor
public class CommentRepositoryImpl implements CommentRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<CommentDto> findCommentInfo(Post post, Pageable pageable) {
        List<CommentDto> results = queryFactory
                .select(new QCommentDto(
                        comment.id,
                        comment.writer.nickname,
                        comment.content,
                        comment.createdDate,
                        comment.post
                ))
                .from(comment)
                .where(comment.post.eq(post))
                .limit(pageable.getPageSize())
                .offset(pageable.getOffset())
                .fetch();

        JPAQuery<Long> countQuery = queryFactory
                .select(comment.count())
                .from(comment)
                .where(comment.post.eq(post));

        return PageableExecutionUtils.getPage(results, pageable, countQuery::fetchOne);
    }
}
