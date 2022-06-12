package yj.capstone.aerofarm.domain.product;

import lombok.Getter;

import javax.persistence.*;

@Entity
@Getter
public class ProductDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 상품의 상세 정보
    private String contents;

    public ProductDetail() {

    }

    public ProductDetail(String contents) {
        this.contents = contents;
    }
}
