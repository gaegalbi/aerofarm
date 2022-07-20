package yj.capstone.aerofarm.form;

import lombok.*;
import yj.capstone.aerofarm.domain.board.Post;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
@NoArgsConstructor
public class PostForm {
    private Long id;

    @NotBlank(message = "카테고리를 선택해주세요.")
    private String category;

    @NotBlank(message = "제목을 입력해주세요.")
    private String title;

    @NotBlank(message = "내용을 입력해주세요.")
    private String contents;

    @NotBlank(message = "필터를 선택해주세요.")
    private String filter;

    private Long postId;

    @Builder(builderClassName = "AnswerFormBuilder", builderMethodName = "answerFormBuilder")
    public PostForm(Post post, String answerString) {
        this.postId = post.getId();
        this.category = post.getCategory().getLowerCase();
        this.filter = post.getFilter().getLowerCase();
        this.title = answerString + post.getTitle();
    }

    @Builder(builderClassName = "UpdateFormBuilder", builderMethodName = "updateFormBuilder")
    public PostForm(Post post) {
        this.postId = post.getId();
        this.category = post.getCategory().getLowerCase();
        this.filter = post.getFilter().getLowerCase();
        this.title = post.getTitle();
        this.contents = post.getContent().getContents();
    }
}
