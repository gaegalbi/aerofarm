package yj.capstone.aerofarm.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductReviewDtos {
    private String orderUuid;
    private List<ProductReviewDto> reviews;
}
