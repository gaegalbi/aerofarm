package yj.capstone.aerofarm.domain.board;

import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.domain.BaseEntity;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
public class PostDetail extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String contents;

    private PostDetail(String contents) {
        this.contents = contents;
    }

    public static PostDetail createPostDetail(String contents) {
        return new PostDetail(contents);
    }
}
