package yj.capstone.aerofarm.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotBlank;

@Getter
@Setter
@ToString
public class ProductReviewDto {
    @NotBlank(message = "이메일을 입력해주세요.")
    private Long productId;
    @NotBlank(message = "이메일을 입력해주세요.")
    private String review;
    @NotBlank(message = "점수를 입력해주세요.")
    @Range(min = 0, max = 5)
    private int score;
}