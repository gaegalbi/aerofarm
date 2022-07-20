package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.board.Comment;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.dto.CommentDto;
import yj.capstone.aerofarm.dto.QCommentDto;
import yj.capstone.aerofarm.dto.response.CommentListResponseDto;
import yj.capstone.aerofarm.dto.response.QCommentListResponseDto;
import yj.capstone.aerofarm.repository.support.Querydsl5RepositorySupport;

import java.util.List;

import static yj.capstone.aerofarm.domain.board.QComment.comment;

public class CommentRepositoryImpl extends Querydsl5RepositorySupport implements CommentRepositoryCustom {

    public CommentRepositoryImpl() {
        super(Comment.class);
    }

    @Override
    public Page<CommentDto> findCommentInfo(Post post, Pageable pageable) {

        return applyPagination(pageable,
                query -> query
                        .select(new QCommentDto(
                                comment.id,
                                comment.writer.nickname,
                                comment.content,
                                comment.modifiedDate,
                                comment.post,
                                comment.writer.id,
                                comment.deleteTnF,
                                comment.groupId,
                                comment.writer.picture,
                                comment.parent.id))
                        .from(comment)
                        .where(
                                comment.post.eq(post),
                                comment.parent.isNull()
                        )
                        .orderBy(comment.createdDate.desc()),
                query -> query
                        .select(comment.count())
                        .from(comment)
                        .where(
                                comment.post.eq(post),
                                comment.parent.isNull()
                        ));
    }

    @Override
    public List<CommentDto> findAnswerCommentInfo(Post post) {
        return select(new QCommentDto(
                comment.id,
                comment.writer.nickname,
                comment.content,
                comment.modifiedDate,
                comment.post,
                comment.writer.id,
                comment.deleteTnF,
                comment.groupId,
                comment.writer.picture,
                comment.parent.id,
                comment.parent.writer.nickname))
                .from(comment)
                .where(
                        comment.post.eq(post),
                        comment.parent.isNotNull()
                )
                .fetch();
    }

    @Override
    public Integer findMaxGroupIdInfo() {
        return select(comment.groupId.max())
                .from(comment)
                .fetchOne();
    }

    @Override
    public Long findAllCommentCount(Post post) {
        return select(comment.id.count())
                .from(comment)
                .where(comment.post.eq(post))
                .fetchOne();
    }

    @Override
    public Page<CommentListResponseDto> findMyComment(Long memberId, Pageable pageable) {
        return applyPagination(pageable,
                query -> query
                        .select(new QCommentListResponseDto(
                                comment.post.id,
                                comment.post.title,
                                comment.content,
                                comment.createdDate,
                                comment.deleteTnF
                        ))
                        .from(comment)
                        .where(comment.writer.id.eq(memberId)),
                query -> query
                        .select(comment.count())
                        .from(comment)
                        .where(comment.writer.id.eq(memberId))
        );
    }
}
