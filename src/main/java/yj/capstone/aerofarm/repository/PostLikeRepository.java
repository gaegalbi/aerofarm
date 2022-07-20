package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.board.PostLike;
import yj.capstone.aerofarm.dto.PostLikeDto;

import java.util.List;

public interface PostLikeRepository extends JpaRepository<PostLike, Long>, PostLikeRepositoryCustom {
    void deleteByMemberIdAndPostId(Long memberId, Long postId);
    boolean existsByMemberIdAndPostId(Long memberId, Long postId);
}
