package yj.capstone.aerofarm.form;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
//@NoArgsConstructor
//@AllArgsConstructor
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
}
