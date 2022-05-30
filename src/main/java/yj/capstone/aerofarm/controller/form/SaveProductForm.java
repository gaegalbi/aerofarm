package yj.capstone.aerofarm.controller.form;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;
import yj.capstone.aerofarm.domain.product.ProductCategory;

import javax.validation.constraints.NotBlank;

@Setter
@Getter
@NoArgsConstructor
public class SaveProductForm {

    @NotBlank(message = "이름을 입력해주세요.")
    private String name;

    @Range(min = 1, max = 1000000)
    private Integer money;

    @Range(min  = 1, max = 9999)
    private Integer stock;

    private ProductCategory category;

    public SaveProductForm(String name, Integer money, Integer stock, ProductCategory category) {
        this.name = name;
        this.money = money;
        this.stock = stock;
        this.category = category;
    }
}
