package yj.capstone.aerofarm.domain.product;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.controller.form.SaveProductForm;
import yj.capstone.aerofarm.domain.BaseEntity;
import yj.capstone.aerofarm.domain.order.Money;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Product extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @Embedded
    @AttributeOverride(name = "money", column = @Column(name = "price"))
    private Money price;

    @Embedded
    private Stock stock;

    @Enumerated(EnumType.STRING)
    private ProductCategory category;

    @Builder
    public Product(SaveProductForm saveProductForm) {
        name = saveProductForm.getName();
        price = new Money(saveProductForm.getMoney());
        stock = new Stock(saveProductForm.getStock());
        category = saveProductForm.getCategory();
    }

    public void increaseStock(int quantity) {
        stock = stock.increaseStock(quantity);
    }

    public void decreaseStock(int quantity) {
        // 재고 수보다 주문 수가 많을 때
        if (stock.getStock() < quantity) {
            throw new IllegalArgumentException("재고가 부족 합니다.");
        }
        stock = stock.decreaseStock(quantity);
    }
}
