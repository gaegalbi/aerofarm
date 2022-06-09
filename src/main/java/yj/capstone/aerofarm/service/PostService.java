package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.board.Comment;
import yj.capstone.aerofarm.dto.CommentDto;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.form.CommentForm;
import yj.capstone.aerofarm.form.PostForm;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.CommentRepository;
import yj.capstone.aerofarm.repository.PostRepository;

import javax.swing.text.html.Option;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class PostService {

    private final PostRepository postRepository;
    private final CommentRepository commentRepository;
    // 게시글 등록
    public Post createPost(Member writer, PostForm postForm) {

        Post post = Post.postBuilder()
                .postForm(postForm)
                .writer(writer)
                .build();

        postRepository.save(post);
        return post;
    }

    // 댓글 등록
    public Comment createComment(Member writer, CommentForm commentForm) {
        Post postId = postRepository.findById(commentForm.getPostId()).orElseThrow(() -> null);

        Comment comment = Comment.commentBuilder()
                .commentForm(commentForm)
                .selectPost(postId)
                .writer(writer)
                .build();

        commentRepository.save(comment);
        return comment;
    }

    // 댓글 가져오기
    public Page<CommentDto> findCommentInfo(Post post, Integer page) {
        PageRequest pageRequest = PageRequest.of(page - 1, 10);
        return commentRepository.findCommentInfo(post, pageRequest);
    }

    // 게시글 검색
    public Page<PostDto> findPostInfo(PostCategory category, String searchCategory, String keyword, Integer page) {
        PageRequest pageRequest = PageRequest.of(page - 1, 10);
        return postRepository.findPostInfo(category, searchCategory, keyword, pageRequest);
    }

    // 선택한 게시물 보기
    public Post selectPost(Long boardId) {
        return postRepository.findById(boardId).orElseThrow(() -> null);
    }

    //게시글 필터링

}
