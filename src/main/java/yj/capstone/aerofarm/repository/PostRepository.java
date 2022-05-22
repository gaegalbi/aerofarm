package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.board.Post;

public interface CommunityRepository extends JpaRepository<Post, Long> {

}
