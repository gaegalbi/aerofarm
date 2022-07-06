package yj.capstone.aerofarm.repository;

import yj.capstone.aerofarm.dto.PostLikeDto;

import java.util.List;

public interface PostLikeRepositoryCustom {
    List<PostLikeDto> findLikeInfo(Long postId);
}
