package yj.capstone.aerofarm.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * File은 JoinTable 고려
 * 조회 수 증가 메소드 구현 시 modified 호출 되므로 추후 BaseEntity 상속 말고 직접 필드 따로 생성 후 비즈니스 로직 작성 고려
 */
@Entity
public class Comment extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member writer;

    private String content;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id")
    private Post post;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private Comment parent;

    @OneToMany(mappedBy = "parent")
    private List<Comment> child = new ArrayList<>();

    /**
     * 추후 필요 시 주석 해제
     */
//    @OneToMany(mappedBy = "comment")
//    private List<File> files = new ArrayList<>();
}
