package yj.capstone.aerofarm.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.controller.dto.QPostDto;
import yj.capstone.aerofarm.domain.board.PostCategory;

import java.util.List;

import static yj.capstone.aerofarm.domain.board.QPost.*;

@RequiredArgsConstructor
public class PostRepositoryImpl implements PostRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<PostDto> findPostInfo(PostCategory category, Pageable pageable) {
        List<PostDto> results = queryFactory
                .select(new QPostDto(
                        post.id,
                        post.title,
                        post.writer.nickname,
                        post.category,
                        post.views,
                        post.likes,
                        post.createdDate))
                .from(post)
                .where(categoryEq(category))
                .limit(pageable.getPageSize())
                .offset(pageable.getOffset())
                .fetch();

        JPAQuery<Long> countQuery = queryFactory
                .select(post.count())
                .from(post)
                .where(categoryEq(category));

        return PageableExecutionUtils.getPage(results, pageable, countQuery::fetchOne);
    }

    private BooleanExpression categoryEq(PostCategory category) {
        return category == null ? null : post.category.eq(category);
    }
}
