package yj.capstone.aerofarm.domain.product;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.exception.NotEnoughStockException;
import yj.capstone.aerofarm.form.SaveProductForm;
import yj.capstone.aerofarm.domain.BaseEntity;
import yj.capstone.aerofarm.domain.order.Money;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

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

    private String imageUrl;

    // 판매량
    @Embedded
    @AttributeOverride(name ="stock", column = @Column(name = "saleCount"))
    private Stock saleCount;

    @Enumerated(EnumType.STRING)
    private ProductCategory category;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<ProductReview> productReviews = new ArrayList<>();

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "contents_id")
    private ProductDetail contents;

    @Builder
    public Product(SaveProductForm saveProductForm) {
        name = saveProductForm.getName();
        price = new Money(saveProductForm.getMoney());
        stock = new Stock(saveProductForm.getStock());
        contents = new ProductDetail(saveProductForm.getProductDetail());
        category = saveProductForm.getCategory();
        saleCount = new Stock(0);
    }

    public void changeImage(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void increaseStock(int quantity) {
        stock = stock.increaseStock(quantity);
        saleCount = saleCount.decreaseStock(quantity);
    }

    public void decreaseStock(int quantity) {
        // 재고 수보다 주문 수가 많을 때
        if (stock.getStock() < quantity) {
            throw new NotEnoughStockException("재고가 부족합니다.");
        }
        stock = stock.decreaseStock(quantity);
        saleCount = saleCount.increaseStock(quantity);
    }
}
