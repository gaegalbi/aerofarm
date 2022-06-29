package yj.capstone.aerofarm.dto.response;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductAdminListResponseDto {
    private Long productId;
    private String name;
    private int price;
    private int saleCount;
    private int stock;
    private long reviewCnt;
    private double scoreAvg;

    public ProductAdminListResponseDto() {
    }

    @QueryProjection
    public ProductAdminListResponseDto(Long productId, String name, int price, int saleCount, int stock, long reviewCnt, double scoreAvg) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.saleCount = saleCount;
        this.stock = stock;
        this.reviewCnt = reviewCnt;
        this.scoreAvg = scoreAvg;
    }
}
