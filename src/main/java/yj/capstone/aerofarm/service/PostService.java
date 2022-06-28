package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.board.*;
import yj.capstone.aerofarm.dto.CommentDto;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.dto.PostLikeDto;
import yj.capstone.aerofarm.form.CommentForm;
import yj.capstone.aerofarm.form.PostForm;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.CommentRepository;
import yj.capstone.aerofarm.repository.PostLikeRepository;
import yj.capstone.aerofarm.repository.PostRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class PostService {

    private final PostRepository postRepository;
    private final CommentRepository commentRepository;
    private final PostLikeRepository postLikeRepository;

    // 게시글 등록
    public Post createBasicPost(Member writer, PostForm postForm) {

        int max = 0;
        if (postRepository.findMaxGroupIdInfo() != null) {
            max = postRepository.findMaxGroupIdInfo();
        }

        Post post = Post.postBuilder()
                .postForm(postForm)
                .writer(writer)
                .groupId(max + 1)
                .build();

        postRepository.save(post);
        return post;
    }

    // 답글 등록
    public Post createAnswerPost(Member writer, PostForm postForm) {
        Post post = Post.postParentBuilder()
                .postForm(postForm)
                .writer(writer)
                .groupId(selectPost(postForm.getPostId()).getGroupId())
                .parent(selectPost(postForm.getPostId()))
                .build();

        postRepository.save(post);
        return post;
    }

    // 댓글 등록
    public Comment createComment(Member writer, CommentForm commentForm) {
        Post post = postRepository.findById(commentForm.getPostId()).orElseThrow(() -> null);

        int max = 0;
        if (commentRepository.findMaxGroupIdInfo() != null) {
            max = commentRepository.findMaxGroupIdInfo();
        }

        Comment comment = Comment.commentBuilder()
                .commentForm(commentForm)
                .selectPost(post)
                .writer(writer)
                .groupId(max + 1)
                .build();

        commentRepository.save(comment);
        return comment;
    }

    // 댓글의 댓글 등록
    public Comment createAnswerComment(Member writer, CommentForm commentForm, Long commentId) {
        Post post = postRepository.findById(commentForm.getPostId()).orElseThrow(() -> null);

        Comment comment = Comment.commentAnswerBuilder()
                .commentForm(commentForm)
                .selectPost(post)
                .writer(writer)
                .parent(selectComment(commentId))
                .groupId(selectPost(post.getId()).getGroupId())
                .build();

        commentRepository.save(comment);
        return comment;
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

    public Post updatePost(PostForm postForm) {
        Post post = postRepository.findById(postForm.getId()).orElseThrow(() -> null);
        post.updateTitle(postForm.getTitle());
        post.updateContent(PostDetail.createPostDetail(postForm.getContents()));

        postRepository.save(post);
        return post;
    }

    // 조회수 업데이트
    public void updateViews(Long postId) {
        Post post = postRepository.findById(postId).orElseThrow(() -> null);
        post.updateViews(post.getViews()+1);
        postRepository.save(post);
    }

    // 게시글 삭제
    public void deletePost(Long postId) {

        Post post = postRepository.findById(postId).orElseThrow(() -> null);
        post.updateDeleteTnF(true);
        postRepository.save(post);
    }

    // 댓글 삭제
    public void deleteComment(Long commentId) {
        Comment comment = commentRepository.findById(commentId).orElseThrow(() -> null);
        comment.updateDeleteTnF(true);
        commentRepository.save(comment);
    }

    // 좋아요 취소
    public void deleteLike(Member member, PostLikeDto postLikeDto) {
        postLikeRepository.deleteByMemberIdAndPostId(member.getId(), postLikeDto.getPostId());
    }

    // 모든 댓글 정보 페이지 단위로 조회
    public Page<CommentDto> findCommentInfo(Post post, Integer page) {
        PageRequest pageRequest = PageRequest.of(page - 1, 10);
        return commentRepository.findCommentInfo(post, pageRequest);
    }

    // 모든 댓글의 답글 정보 조회
    public List<CommentDto> findAnswerCommentInfo(Post post) {
        return commentRepository.findAnswerCommentInfo(post);
    }

    // 모든 게시글 정보 페이지 단위로 조회
    public Page<PostDto> findPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter, Integer page) {
        PageRequest pageRequest = PageRequest.of(page - 1, 10);
        return postRepository.findPostInfo(category, searchCategory, keyword, postFilter, pageRequest);
    }

    // 모든 답글 정보 조회
    public List<PostDto> findAnswerPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter) {
        return postRepository.findAnswerPostInfo(category, searchCategory, keyword, postFilter);
    }

    // 해당 게시글 정보 조회
    public Post selectPost(Long postId) {
        return postRepository.findById(postId).orElseThrow(() -> null);
    }

    // 해당 댓글 정보 조회
    public Comment selectComment(Long commentId) { return commentRepository.findById(commentId).orElseThrow(() -> null); }

    // 좋아요 개수 조회
    public List<PostLikeDto> findLikeInfo(Long postId) {
        return postLikeRepository.findLikeInfo(postId);
    }

    // 좋아요 누름 여부 조회
    public List<PostLike> isMemberSelectInfo(Long memberId, Long postId) {
        return postLikeRepository.findByMemberIdAndPostId(memberId, postId);
    }

}
