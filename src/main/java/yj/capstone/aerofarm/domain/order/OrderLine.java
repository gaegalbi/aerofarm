package yj.capstone.aerofarm.domain.order;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.domain.BaseEntity;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.dto.CartDto;

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

    private OrderLine(Product product,Money price ,int quantity) {
        this.quantity = quantity;
        this.product = product;
        this.price = price;
    }

    public static OrderLine createOrderLine(Product product, CartDto cartDto) {
        product.decreaseStock(cartDto.getQuantity());
        return new OrderLine(product, product.getPrice(), cartDto.getQuantity());
    }
}
