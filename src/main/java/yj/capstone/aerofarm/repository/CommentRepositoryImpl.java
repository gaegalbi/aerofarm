package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.board.Comment;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.dto.CommentDto;
import yj.capstone.aerofarm.dto.QCommentDto;
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
                                comment.createdDate,
                                comment.post,
                                comment.writer.id,
                                comment.deleteTnF))
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
                comment.createdDate,
                comment.post,
                comment.writer.id,
                comment.deleteTnF))
                .from(comment)
                .where(
                        comment.post.eq(post),
                        comment.parent.isNotNull()
                )
                .orderBy(comment.createdDate.desc())
                .fetch();
    }
}
