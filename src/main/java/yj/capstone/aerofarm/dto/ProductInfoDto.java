package yj.capstone.aerofarm.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductInfoDto {
    private String imageUrl;
    private String name;
    private int price;
    private long reviewCnt;
    private double scoreAvg;

    @QueryProjection
    public ProductInfoDto(String imageUrl, String name, int price, long reviewCnt, double scoreAvg) {
        this.imageUrl = imageUrl;
        this.name = name;
        this.price = price;
        this.reviewCnt = reviewCnt;
        this.scoreAvg = scoreAvg;
    }
}
