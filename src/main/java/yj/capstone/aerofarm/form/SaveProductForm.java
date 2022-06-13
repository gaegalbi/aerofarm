package yj.capstone.aerofarm.form;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;
import yj.capstone.aerofarm.domain.product.ProductCategory;

import javax.validation.constraints.NotBlank;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class SaveProductForm {

    @NotBlank(message = "이름을 입력해주세요.")
    private String name;

    @Range(min = 1, max = 1000000)
    private Integer money;

    @Range(min  = 1, max = 9999)
    private Integer stock;

    private ProductCategory category;

    private String productDetail;

    private MultipartFile image;
}
