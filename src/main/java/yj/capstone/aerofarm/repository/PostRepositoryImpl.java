package yj.capstone.aerofarm.repository;

import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.JPAExpressions;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.board.*;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.dto.QPostDto;
import yj.capstone.aerofarm.repository.support.Querydsl5RepositorySupport;

import java.util.List;

import static yj.capstone.aerofarm.domain.board.QPost.post;

public class PostRepositoryImpl extends Querydsl5RepositorySupport implements PostRepositoryCustom {

    public PostRepositoryImpl() {
        super(Post.class);
    }

    @Override
    public Page<PostDto> findPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter, Pageable pageable) {
        QComment commentSub = new QComment("commentSub");
        QPostLike postLikeSub = new QPostLike("likeCount");

        return applyPagination(pageable,
                query -> query
                        .select(new QPostDto(
                                        post.id,
                                        post.title,
                                        post.writer.nickname.as("writer"),
                                        post.category,
                                        post.filter,
                                        post.views,
                                        post.createdDate,
                                        ExpressionUtils.as(
                                                JPAExpressions
                                                        .select(commentSub.post.count())
                                                        .from(commentSub)
                                                        .groupBy(commentSub.post)
                                                        .having(commentSub.post.eq(post)), "commentCount"),
                                        ExpressionUtils.as(
                                                JPAExpressions
                                                        .select(postLikeSub.post.count())
                                                        .from(postLikeSub)
                                                        .groupBy(postLikeSub.post)
                                                        .having(postLikeSub.post.eq(post)), "likeCount"),
                                        post.parent.id,
                                        post.groupId,
                                        post.deleteTnF))
                        .from(post)
                        .where(
                                categoryEq(category),
                                titleOrWriterEq(searchCategory, keyword),
                                filterEq(postFilter),
                                post.parent.id.isNull()
                        )
                        .orderBy(post.createdDate.desc()),
                query -> query
                        .select(post.count())
                        .from(post)
                        .where(
                                categoryEq(category),
                                titleOrWriterEq(searchCategory, keyword),
                                filterEq(postFilter),
                                post.parent.id.isNull()
                        ));
    }

    @Override
    public List<PostDto> findAnswerPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter) {
        QComment commentSub = new QComment("commentSub");
        QPostLike postLikeSub = new QPostLike("likeCount");

        return select(new QPostDto(
                post.id,
                post.title,
                post.writer.nickname.as("writer"),
                post.category,
                post.filter,
                post.views,
                post.createdDate,
                ExpressionUtils.as(
                        JPAExpressions
                                .select(commentSub.post.count())
                                .from(commentSub)
                                .groupBy(commentSub.post)
                                .having(commentSub.post.eq(post)), "commentCount"),
                ExpressionUtils.as(
                        JPAExpressions
                                .select(postLikeSub.post.count())
                                .from(postLikeSub)
                                .groupBy(postLikeSub.post)
                                .having(postLikeSub.post.eq(post)), "likeCount"),
                post.parent.id,
                post.groupId,
                post.deleteTnF))
                .from(post)
                .where(
                        categoryEq(category),
                        titleOrWriterEq(searchCategory, keyword),
                        filterEq(postFilter),
                        post.parent.id.isNotNull()
                )
                .fetch();
    }

    @Override
    public Integer findMaxGroupIdInfo() {
        return select(post.groupId.max())
                .from(post)
                .fetchOne();
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

    private BooleanExpression filterEq(PostFilter filter) {
        return filter == null ? null : post.filter.eq(filter);
    }
}
