package yj.capstone.aerofarm.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderLineDto {
    private ProductDto productDto;
    private int quantity;
    private int price;

    public OrderLineDto() {
    }

    public OrderLineDto(ProductDto productDto, int quantity, int price) {
        this.productDto = productDto;
        this.quantity = quantity;
        this.price = price;
    }
}
