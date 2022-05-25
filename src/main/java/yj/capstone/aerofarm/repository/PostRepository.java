package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.controller.dto.PostDto;

public interface PostRepository extends JpaRepository<PostDto, Long> {
}
