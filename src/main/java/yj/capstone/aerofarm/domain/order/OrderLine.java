package yj.capstone.aerofarm.domain.order;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.controller.dto.OrderLineDto;
import yj.capstone.aerofarm.domain.BaseEntity;
import yj.capstone.aerofarm.domain.product.Product;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OrderLine extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    private int quantity;

    @Embedded
    private Money price;

    public int getOrderPrice() {
        return price.getPrice() * quantity;
    }

    @Builder
    public OrderLine(OrderLineDto orderLineDto) {
        this.quantity = orderLineDto.getQuantity();
        this.price = new Money(orderLineDto.getPrice());
    }
}
