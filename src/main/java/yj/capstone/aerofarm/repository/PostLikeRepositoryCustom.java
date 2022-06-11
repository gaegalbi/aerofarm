package yj.capstone.aerofarm.repository;

import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.PostLikeDto;

import java.util.List;

public interface PostLikeRepositoryCustom {
    List<PostLikeDto> findLikeInfo(Long postId);
    List<Long> isMemberSelectInfo(Member member, Long postId);
}
