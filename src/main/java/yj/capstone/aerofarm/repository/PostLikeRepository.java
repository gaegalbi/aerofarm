package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.board.PostLike;

public interface PostLikeRepository extends JpaRepository<PostLike, Long>, PostLikeRepositoryCustom {
    void deleteByMemberIdAndPostId(Long memberId, Long postId);
    Long findByMemberIdAndPostId(Long memberId, Long postId);
}
