package yj.capstone.aerofarm.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import yj.capstone.aerofarm.domain.board.PostLike;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.PostLikeDto;
import yj.capstone.aerofarm.dto.QPostLikeDto;
import yj.capstone.aerofarm.repository.support.Querydsl5RepositorySupport;

import java.util.List;

import static yj.capstone.aerofarm.domain.board.QPostLike.postLike;

public class PostLikeRepositoryImpl extends Querydsl5RepositorySupport implements PostLikeRepositoryCustom {

    public PostLikeRepositoryImpl() {
        super(PostLike.class);
    }

    @Override
    public List<PostLikeDto> findLikeInfo(Long postId) {

        return select(new QPostLikeDto(
                        postLike.post.id,
                        postLike.count()))
                .from(postLike)
                .groupBy(postLike.post)
                .having(postLike.post.id.eq(postId))
                .fetch();
    }

    @Override
    public List<Long> isMemberSelectInfo(Member member, Long postId) {

        return select(postLike.id)
                .from(postLike)
                .where(
                        memberEq(member),
                        postLike.post.id.eq(postId))
                .fetch();
    }

    private BooleanExpression memberEq(Member member) {
        return member == null ? null : postLike.member.eq(member);
    }
}
