package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.controller.dto.PostDto;
import yj.capstone.aerofarm.controller.form.PostForm;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.PostRepository;

@Service
@RequiredArgsConstructor
@Transactional
public class PostService {

    private final PostRepository postRepository;
    // 게시글 등록
    public Post createPost(Member writer, PostForm postForm) {

        Post post = Post.postBuilder()
                .postForm(postForm)
                .writer(writer)
                .build();

        postRepository.save(post);
        return post;
    }

    // 게시글 목록 조회
//    public List<Post> findPosts(PostCategory category) {
//
//        return postRepository.findByCategory(category);
//    }

    public Page<PostDto> findPostInfo(PostCategory category, Integer page) {
        PageRequest pageRequest = PageRequest.of(page - 1, 10);
        return postRepository.findPostInfo(category, pageRequest);
    }

    // 선택한 게시물 보기
    public Post selectPost(Long boardId) {
        return postRepository.findById(boardId).orElseThrow(() -> null);
    }

    //게시글 필터링

}
