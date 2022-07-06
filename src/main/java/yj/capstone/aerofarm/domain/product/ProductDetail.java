package yj.capstone.aerofarm.domain.product;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor
public class ProductDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 상품의 상세 정보
    private String contents;

    public ProductDetail(String contents) {
        this.contents = contents;
    }
}
