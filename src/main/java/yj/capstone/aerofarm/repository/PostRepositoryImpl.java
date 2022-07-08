package yj.capstone.aerofarm.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.NumberPath;
import com.querydsl.core.types.dsl.StringPath;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.board.*;
import yj.capstone.aerofarm.domain.member.QMember;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.dto.QPostDto;
import yj.capstone.aerofarm.dto.response.PostListResponseDto;
import yj.capstone.aerofarm.dto.response.QPostListResponseDto;
import yj.capstone.aerofarm.repository.support.Querydsl5RepositorySupport;

import java.util.List;

import static yj.capstone.aerofarm.domain.board.QPost.post;
import static yj.capstone.aerofarm.domain.board.QComment.*;
import static yj.capstone.aerofarm.domain.board.QPostLike.*;
import static yj.capstone.aerofarm.domain.member.QMember.member;

public class PostRepositoryImpl extends Querydsl5RepositorySupport implements PostRepositoryCustom {

    public PostRepositoryImpl() {
        super(Post.class);
    }

    @Override
    public Page<PostDto> findPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter, Pageable pageable) {

        return applyPagination(pageable,
                query -> query
                        .select(new QPostDto(
                                        post.id,
                                        post.title,
                                        post.writer.nickname.as("writer"),
                                        post.category,
                                        post.filter,
                                        post.views,
                                        post.content.modifiedDate,
                                        comment.id.countDistinct().as("commentCount"),
                                        postLike.id.countDistinct().as("likeCount"),
                                        post.parent.id,
                                        post.groupId,
                                        post.deleteTnF))
                        .from(post)
                        .leftJoin(comment).on(post.id.eq(comment.post.id))
                        .leftJoin(postLike).on(post.id.eq(postLike.post.id))
                        .where(
                                categoryEq(category),
                                titleOrWriterEq(searchCategory, keyword),
                                filterEq(postFilter),
                                post.parent.id.isNull()
                        )
                        .groupBy(post.id)
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

        return select(new QPostDto(
                post.id,
                post.title,
                post.writer.nickname.as("writer"),
                post.category,
                post.filter,
                post.views,
                post.content.modifiedDate,
                comment.id.countDistinct().as("commentCount"),
                postLike.id.countDistinct().as("likeCount"),
                post.parent.id,
                post.groupId,
                post.deleteTnF))
                .from(post)
                .leftJoin(comment).on(post.id.eq(comment.post.id))
                .leftJoin(postLike).on(post.id.eq(postLike.post.id))
                .innerJoin(post.writer, member)
                .where(
                        categoryEq(category),
                        titleOrWriterEq(searchCategory, keyword),
                        filterEq(postFilter),
                        post.parent.id.isNotNull()
                )
                .groupBy(post.id)
                .fetch();
    }

    @Override
    public Page<PostDto> findHotPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter, Pageable pageable) {
        NumberPath<Long> aliasQuantity = Expressions.numberPath(Long.class, "col_8_0_");

        return applyPagination(pageable,
                query -> query
                        .select(new QPostDto(
                                post.id,
                                post.title,
                                post.writer.nickname.as("writer"),
                                post.category,
                                post.filter,
                                post.views,
                                post.content.modifiedDate,
                                comment.id.countDistinct().as("commentCount"),
                                postLike.id.countDistinct().as(aliasQuantity),
                                post.parent.id,
                                post.groupId,
                                post.deleteTnF))
                        .from(post)
                        .leftJoin(comment).on(post.id.eq(comment.post.id))
                        .leftJoin(postLike).on(post.id.eq(postLike.post.id))
                        .where(
                                categoryEq(category),
                                titleOrWriterEq(searchCategory, keyword),
                                filterEq(postFilter)
                        )
                        .groupBy(post.id)
                        .orderBy(aliasQuantity.desc(), post.createdDate.desc())
                        .having(postLike.id.countDistinct().goe(3)),
                query -> query
                        .select(post.countDistinct())
                        .from(post)
                        .leftJoin(postLike).on(post.id.eq(postLike.post.id))
                        .where(
                                categoryEq(category),
                                titleOrWriterEq(searchCategory, keyword),
                                filterEq(postFilter)
                        )
                        .groupBy(post.id)
                        .having(postLike.id.countDistinct().goe(3)));
    }

    @Override
    public Integer findMaxGroupIdInfo() {
        return select(post.groupId.max())
                .from(post)
                .fetchOne();
    }

    @Override
    public Page<PostListResponseDto> findMyPost(Long memberId, Pageable pageable) {
        return applyPagination(pageable,
                query -> query
                        .select(new QPostListResponseDto(
                                post.id,
                                post.title,
                                post.modifiedDate,
                                postLike.count(),
                                post.views,
                                post.filter,
                                post.category
                        ))
                        .from(postLike)
                        .rightJoin(postLike.post, post)
                        .groupBy(post.id)
                        .where(post.writer.id.eq(memberId)),
                query -> query
                        .select(post.count())
                        .from(post)
                        .where(post.writer.id.eq(memberId))
        );
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
