package yj.capstone.aerofarm.domain.board;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.domain.BaseEntity;
import yj.capstone.aerofarm.domain.chat.Extension;

import javax.persistence.*;

/**
 * Post, Comment 참조 객체가 필요할까?
 * 혹은 Post, Comment의 부모 클래스를 만들어 참조하게 할까? (Null 방지, Dtype)
 * Comment, Post는 JoinTable 고려
 */
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class File extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String url;

    @Enumerated(EnumType.STRING)
    private Extension extension;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "comment_id")
    private Comment comment;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id")
    private Post post;
}
