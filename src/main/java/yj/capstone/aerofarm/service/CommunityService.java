package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.repository.CommunityRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class CommunityService {
    private final CommunityRepository communityRepository;

    // 게시글 등록
    public Long join(Post post) {
        communityRepository.save(post);
        return post.getId();
    }

    // 게시글 목록 조회
    public List<Post> findPosts() {
        return communityRepository.findAll();
    }

    //게시글 필터링

}
