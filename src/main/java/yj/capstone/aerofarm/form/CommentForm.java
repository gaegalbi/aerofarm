package yj.capstone.aerofarm.form;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CommentForm {
    private Long postId;

    @NotBlank(message = "내용을 입력해주세요.")
    private String content;

    private Long commentId;
}
