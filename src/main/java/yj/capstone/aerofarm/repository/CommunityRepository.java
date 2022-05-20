package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.board.Post;

import java.util.Optional;

public interface CommunityRepository extends JpaRepository<Post, Long> {

    Optional<Post> findAllByPost();
}
