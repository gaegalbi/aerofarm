package yj.capstone.aerofarm.domain.order;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.dto.OrderLineDto;
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

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "product_id")
    private Product product;

    private int quantity;

    @Embedded
    private Money price;

    public int getOrderPrice() {
        return price.getMoney() * quantity;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    private OrderLine(OrderLineDto orderLineDto, Product product) {
        this.quantity = orderLineDto.getQuantity();
        this.price = new Money(orderLineDto.getPrice());
        this.product = product;
    }

    public static OrderLine createOrderLine(OrderLineDto orderLineDto, Product product) {
        return new OrderLine(orderLineDto, product);
    }
}
