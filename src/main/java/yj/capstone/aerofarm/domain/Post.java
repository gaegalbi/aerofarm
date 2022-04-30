package yj.capstone.aerofarm.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * File은 JoinTable 고려
 */
@Entity
public class Post extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member writer;

    private String content;

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
    private int hits;

    // 추천수
    private int likes;

}
