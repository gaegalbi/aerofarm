package yj.capstone.aerofarm.controller.form;

import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.board.PostDetail;

@Getter
@Setter
public class PostForm {
    private String category;
    private int likes = 0;
    private String title;
    private int views = 0;
    private String postDetail;
}
