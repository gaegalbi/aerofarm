package yj.capstone.aerofarm.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import yj.capstone.aerofarm.domain.product.Product;

@Getter
@Setter
@NoArgsConstructor
public class ProductStoreDetailDto {
    private Long id;
    private String name;
    private int price;
    private String contents;
    private String imageUrl;

    public ProductStoreDetailDto(Product product) {
        this.id = product.getId();
        this.name = product.getName();
        this.price = product.getPrice().getMoney();
        this.contents = product.getContents().getContents();
        this.imageUrl = product.getImageUrl();
    }
}
