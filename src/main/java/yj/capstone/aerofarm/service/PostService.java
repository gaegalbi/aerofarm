package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.board.*;
import yj.capstone.aerofarm.dto.CommentDto;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.dto.PostLikeDto;
import yj.capstone.aerofarm.dto.response.CommentListResponseDto;
import yj.capstone.aerofarm.dto.response.PostListResponseDto;
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
    public void createBasicPost(Member writer, PostForm postForm) {

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
    }

    // 답글 등록
    public void createAnswerPost(Member writer, PostForm postForm) {
        Post post = Post.postParentBuilder()
                .postForm(postForm)
                .writer(writer)
                .groupId(selectPost(postForm.getPostId()).getGroupId())
                .parent(selectPost(postForm.getPostId()))
                .build();

        postRepository.save(post);
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
    public Comment createAnswerComment(Member writer, CommentForm commentForm) {
        Post post = postRepository.findById(commentForm.getPostId()).orElseThrow(() -> null);

        Comment comment = Comment.commentAnswerBuilder()
                .commentForm(commentForm)
                .selectPost(post)
                .writer(writer)
                .parent(selectComment(commentForm.getCommentId()))
                .groupId(selectComment(commentForm.getCommentId()).getGroupId())
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

    // 게시글 수정
    public void updatePost(PostForm postForm) {
        Post post = postRepository.findById(postForm.getId()).orElseThrow(() -> null);
        post.updateTitle(postForm.getTitle());
        post.updateContent(PostDetail.createPostDetail(postForm.getContents()));

        postRepository.save(post);
    }

    // 댓글 수정
    public Comment updateComment(CommentForm commentForm) {
        Comment comment = commentRepository.findById(commentForm.getId()).orElseThrow(() -> null);
        comment.updateContent(commentForm.getContent());

        commentRepository.save(comment);
        return comment;
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
    public Page<CommentDto> findCommentInfo(Post post, Pageable pageable) {
        return commentRepository.findCommentInfo(post, pageable);
    }

    // 모든 댓글의 답글 정보 조회
    public List<CommentDto> findAnswerCommentInfo(Post post) {
        return commentRepository.findAnswerCommentInfo(post);
    }

    // 모든 게시글 정보 페이지 단위로 조회
    public Page<PostDto> findPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter, Pageable pageable) {
        return postRepository.findPostInfo(category, searchCategory, keyword, postFilter, pageable);
    }

    // 모든 답글 정보 조회
    public List<PostDto> findAnswerPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter) {
        return postRepository.findAnswerPostInfo(category, searchCategory, keyword, postFilter);
    }

    // 해당 게시글 정보 조회
    public Post selectPost(Long postId) {
        return postRepository.findById(postId).orElseThrow(() -> null);
    }

    // 인기 게시글 조회
    public Page<PostDto> findHotPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter, Pageable pageable) {
        return postRepository.findHotPostInfo(category, searchCategory, keyword, postFilter, pageable);
    }

    // 해당 댓글 정보 조회
    public Comment selectComment(Long commentId) { return commentRepository.findById(commentId).orElseThrow(() -> null); }

    // 해당 게시글에 포함된 모든 댓글 개수
    public Long commentCount(Post post) { return commentRepository.findAllCommentCount(post); }

    // 좋아요 개수 조회
    public List<PostLikeDto> findLikeInfo(Long postId) {
        return postLikeRepository.findLikeInfo(postId);
    }

    // 좋아요 누름 여부 조회
    public List<PostLike> isMemberSelectInfo(Long memberId, Long postId) {
        return postLikeRepository.findByMemberIdAndPostId(memberId, postId);
    }

    public Page<PostListResponseDto> findMyPostList(Long memberId, Pageable pageable) {
        return postRepository.findMyPost(memberId, pageable);
    }

    public Page<CommentListResponseDto> findMyCommentList(Long memberId, Pageable pageable) {
        return commentRepository.findMyComment(memberId, pageable);
    }
}
