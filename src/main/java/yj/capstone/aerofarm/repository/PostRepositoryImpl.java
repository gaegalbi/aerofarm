package yj.capstone.aerofarm.repository;

import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.dto.QPostDto;
import yj.capstone.aerofarm.domain.board.PostCategory;

import java.util.List;

import static yj.capstone.aerofarm.domain.board.QPost.post;
import static yj.capstone.aerofarm.domain.board.QComment.comment;
import static yj.capstone.aerofarm.domain.board.QPostLike.postLike;

@RequiredArgsConstructor
public class PostRepositoryImpl implements PostRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<PostDto> findPostInfo(PostCategory category, String searchCategory, String keyword, Pageable pageable) {
        List<PostDto> results = queryFactory
                .select(new QPostDto(
                        post.id,
                        post.title,
                        post.writer.nickname.as("writer"),
                        post.category,
                        post.views,
                        post.createdDate,
                        comment.count().as("commentCount"),
                        postLike.count().as("likeCount")
                ))
                .from(post)
//                .leftJoin(comment).on(post.eq(comment.post))
                .join(post.comments, comment).on(comment.post.eq(post))
                .join(post.likes, postLike).on(postLike.post.eq(post))
                .where(
                        categoryEq(category),
                        titleOrWriterEq(searchCategory, keyword)
                )
                .groupBy(post.id)
                .orderBy(post.createdDate.desc())
                .limit(pageable.getPageSize())
                .offset(pageable.getOffset())
                .fetch();

        JPAQuery<Long> countQuery = queryFactory
                .select(post.count())
                .from(post)
                .where(
                        categoryEq(category),
                        titleOrWriterEq(searchCategory, keyword)
                );

        return PageableExecutionUtils.getPage(results, pageable, countQuery::fetchOne);
    }

    @Override
    public List<PostDto> findPostLikeInfo(PostCategory category, String searchCategory, String keyword, Pageable pageable) {
        List<PostDto> results = queryFactory
                .select(new QPostDto(
                        post.id,
                        post.title,
                        post.writer.nickname,
                        post.category,
                        post.views,
                        post.createdDate,
                        comment.count(),
                        postLike.count()
                ))
                .from(post)
                .leftJoin(postLike).on(post.eq(postLike.post))
                .where(
                        categoryEq(category),
                        titleOrWriterEq(searchCategory, keyword)
                )
                .groupBy(post.id)
                .orderBy(post.createdDate.desc())
                .limit(pageable.getPageSize())
                .offset(pageable.getOffset())
                .fetch();

        return results;
    }

    private BooleanExpression categoryEq(PostCategory category) {
        return category == null ? null : post.category.eq(category);
    }

    private BooleanExpression titleOrWriterEq(String searchCategory, String keyword) {
        if (searchCategory.equals("title"))
            return keyword == null ? null : post.title.like("%" + keyword + "%");
        else
            return keyword == null ? null : post.writer.nickname.like("%" + keyword + "%");
    }
}
