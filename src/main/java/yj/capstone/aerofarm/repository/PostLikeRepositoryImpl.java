package yj.capstone.aerofarm.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.PostLikeDto;
import yj.capstone.aerofarm.dto.QPostLikeDto;

import java.util.List;

import static yj.capstone.aerofarm.domain.board.QPostLike.postLike;

@RequiredArgsConstructor
public class PostLikeRepositoryImpl implements PostLikeRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public List<PostLikeDto> findLikeInfo(Long postId) {
        List<PostLikeDto> results = queryFactory
                .select(new QPostLikeDto(
                        postLike.post.id,
                        postLike.count()
                ))
                .from(postLike)
                .groupBy(postLike.post)
                .having(postLike.post.id.eq(postId))
                .fetch();

        return results;
    }

    @Override
    public List<Long> isMemberSelectInfo(Member member, Long postId) {
        List<Long> results = queryFactory
                .select(postLike.id)
                .from(postLike)
                .where(
                        memberEq(member),
                        postLike.post.id.eq(postId)
                )
                .fetch();

        return results;
    }

    private BooleanExpression memberEq(Member member) {
        return member == null ? null : postLike.member.eq(member);
    }
}
