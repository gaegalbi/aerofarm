package yj.capstone.aerofarm.domain.product;

import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.domain.BaseEntity;

import javax.persistence.*;

@Entity
@NoArgsConstructor
public class ProductReview extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    private double score;

    private String review;

    public ProductReview(Product product, double score, String review) {
        product.getProductReviews().add(this);
        this.product = product;
        this.score = score;
        this.review = review;
    }
}
