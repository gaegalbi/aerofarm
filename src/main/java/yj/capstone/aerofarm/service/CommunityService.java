package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.controller.dto.PostDto;
import yj.capstone.aerofarm.controller.dto.PostViewDto;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostDetail;
import yj.capstone.aerofarm.repository.CommunityRepository;
import yj.capstone.aerofarm.repository.PostDetailRepository;
import yj.capstone.aerofarm.repository.PostRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class CommunityService {

    private final CommunityRepository communityRepository;
    private final PostDetailRepository postDetailRepository;
    private final PostRepository postRepository;

    // 게시글 상세 내용 등록
    public PostDetail postDetailJoin(PostDetail postDetail) {
        postDetailRepository.save(postDetail);
        return postDetail;
    }

    // 게시글 등록
    public Long postJoin(PostDto postDto) {
        postRepository.save(postDto);
        return postDto.getId();
    }

    // 게시글 목록 조회
    public List<Post> findPosts() {
        return communityRepository.findAll();
    }

    //게시글 필터링

}
