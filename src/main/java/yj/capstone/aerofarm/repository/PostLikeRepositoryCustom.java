package yj.capstone.aerofarm.repository;

import yj.capstone.aerofarm.dto.PostLikeDto;

import java.util.List;

public interface PostLikeRepositoryCustom {
    Long findLikeCount(Long postId);
}
