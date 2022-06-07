package yj.capstone.aerofarm.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import yj.capstone.aerofarm.domain.product.Product;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductDto {
    private Long id;
    private String name;
    private int price;

    public ProductDto(Product product) {
        this.id = product.getId();
        this.name = product.getName();
        this.price = product.getPrice().getMoney();
    }
}
