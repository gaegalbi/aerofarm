package yj.capstone.aerofarm.domain.product;

import lombok.Builder;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.domain.BaseEntity;
import yj.capstone.aerofarm.domain.member.Member;

import javax.persistence.*;

@Entity
@NoArgsConstructor
public class ProductReview extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 해당 리뷰의 상품
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    // 리뷰를 작성한 멤버
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    // 해당 리뷰의 평점
    private double score;

    // 해당 리뷰의 내용
    private String review;

    @Builder
    public ProductReview(Product product, Member member, double score, String review) {
        product.getProductReviews().add(this);
        this.member = member;
        this.product = product;
        this.score = score;
        this.review = review;
    }
}
