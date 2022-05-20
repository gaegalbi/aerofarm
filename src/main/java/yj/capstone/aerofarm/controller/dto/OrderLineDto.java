package yj.capstone.aerofarm.controller.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderLineDto {
    private Long productId;
    private int quantity;
    private int price;

    public OrderLineDto() {
    }

    public OrderLineDto(Long productId, int quantity, int price) {
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }
}
