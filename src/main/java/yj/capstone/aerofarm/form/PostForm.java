package yj.capstone.aerofarm.form;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PostForm {
    private String category;
    private String title;
    private String contents;
    private String filter;
}
