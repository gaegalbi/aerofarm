package yj.capstone.aerofarm.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductStoreInfoDto {
    private Long productId;
    private String imageUrl;
    private String name;
    private int price;
    private long reviewCnt;
    private double scoreAvg;

    @QueryProjection
    public ProductStoreInfoDto(Long productId, String imageUrl, String name, int price, long reviewCnt, double scoreAvg) {
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.name = name;
        this.price = price;
        this.reviewCnt = reviewCnt;
        this.scoreAvg = scoreAvg;
    }
}
