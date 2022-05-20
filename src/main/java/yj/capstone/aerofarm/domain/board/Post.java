package yj.capstone.aerofarm.domain.board;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
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

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_detail_id")
    private PostDetail content;

    @OneToMany(mappedBy = "post")
    private List<File> files = new ArrayList<>();

    private String title;

    @Enumerated(EnumType.STRING)
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

    // 추천수
    private int likes;

}
