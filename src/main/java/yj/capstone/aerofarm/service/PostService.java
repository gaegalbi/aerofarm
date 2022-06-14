package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.board.Comment;
import yj.capstone.aerofarm.domain.board.PostLike;
import yj.capstone.aerofarm.dto.CommentDto;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.dto.PostLikeDto;
import yj.capstone.aerofarm.form.CommentForm;
import yj.capstone.aerofarm.form.PostForm;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.CommentRepository;
import yj.capstone.aerofarm.repository.PostLikeRepository;
import yj.capstone.aerofarm.repository.PostRepository;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class PostService {

    private final PostRepository postRepository;
    private final CommentRepository commentRepository;
    private final PostLikeRepository postLikeRepository;

    // 게시글 등록
    public Post createBasicPost(Member writer, PostForm postForm) {

        Post post = Post.postBuilder()
                .postForm(postForm)
                .writer(writer)
                .build();

        postRepository.save(post);
        return post;
    }

    // 답글 등록
    public Post createAnswerPost(Member writer, PostForm postForm, Long postId) {
        Post post = Post.postParentBuilder()
                .postForm(postForm)
                .writer(writer)
                .parent(selectPost(postId))
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

    // 좋아요 등록
    public PostLike createLike(Member member, PostLikeDto postLikeDto) {
        Post postId = postRepository.findById(postLikeDto.getPostId()).orElseThrow(() -> null);

        PostLike postLike = PostLike.postLikeBuilder()
                .member(member)
                .post(postId)
                .build();

        postLikeRepository.save(postLike);
        return postLike;
    }

    // 좋아요 취소
    public void deleteLike(Member member, PostLikeDto postLikeDto) {
        postLikeRepository.deleteByMemberIdAndPostId(member.getId(), postLikeDto.getPostId());
    }

    // 좋아요 개수 탐색
    public List<PostLikeDto> findLikeInfo(Long postId) {
        return postLikeRepository.findLikeInfo(postId);
    }

    // 좋아요 누름 여부
    public List<Long> isMemberSelectInfo(Member member, Long postId) {
        return postLikeRepository.isMemberSelectInfo(member, postId);
    }

    // 조회수 업데이트
    public void updateViews(Long postId) {
        Post post = postRepository.findById(postId).orElseThrow(() -> null);
        post.updateViews(post.getViews()+1);
        postRepository.save(post);
    }

    //게시글 필터링

}
