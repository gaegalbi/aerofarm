package yj.capstone.aerofarm.domain.board;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.form.PostForm;
import yj.capstone.aerofarm.domain.BaseEntity;
import yj.capstone.aerofarm.domain.member.Member;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * File은 JoinTable 고려
 * 조회 수 증가 메소드 구현 시 modified 호출 되므로 추후 BaseEntity 상속 말고 직접 필드 따로 생성 후 비즈니스 로직 작성 고려
 */
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class Post extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member writer;

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "post_detail_id")
    private PostDetail content;

    @OneToMany(mappedBy = "post")
    private List<File> files = new ArrayList<>();

    private String title;

//    @Enumerated(EnumType.STRING)
    @Convert(converter = CategoryConverter.class)
    private PostCategory category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private Post parent;

    @OneToMany(mappedBy = "parent")
    private List<Post> child = new ArrayList<>();

    /**
     * 추후 필요 시 주석 해제
     */
//    @OneToMany(mappedBy = "post")
//    private List<Comment> comments = new ArrayList<>();

    // 조회수
    private int views;

    // 삭제 여부
    private boolean deleteTnF;

    @Builder(builderClassName = "PostBuilder", builderMethodName = "postBuilder")
    public Post(PostForm postForm, Member writer) {
        this.writer = writer;
        this.title = postForm.getTitle();
        this.content = PostDetail.createPostDetail(postForm.getContents());
        this.category = PostCategory.findByLowerCase(postForm.getCategory());
    }

    @Builder(builderClassName = "PostParentBuilder", builderMethodName = "postParentBuilder")
    public Post(PostForm postForm, Member writer, Post parent) {
        this.writer = writer;
        this.title = postForm.getTitle();
        this.content = PostDetail.createPostDetail(postForm.getContents());
        this.category = PostCategory.findByLowerCase(postForm.getCategory());
        this.parent = parent;
    }

    public void updateViews(int views) {
        this.views = views;
    }
    public void updateDeleteTnF(boolean deleteTnF) {
        this.deleteTnF = deleteTnF;
    }
}
