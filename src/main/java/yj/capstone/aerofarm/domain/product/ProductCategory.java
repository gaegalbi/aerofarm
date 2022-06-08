package yj.capstone.aerofarm.domain.product;

import lombok.Getter;
import yj.capstone.aerofarm.exception.NoCategoryFoundException;

import java.util.Arrays;

@Getter
public enum ProductCategory {

    DEVICE("device", "기기"),
    SEED("seed", "씨앗"),
    FERTILIZER("fertilizer", "양액"),
    ETC("etc", "기타");

    private final String lowerCase;
    private final String name;

    ProductCategory(String lowerCase, String name) {
        this.lowerCase = lowerCase;
        this.name = name;
    }

    public static ProductCategory findByLowerCase(String lowerCase) {
        return Arrays.stream(ProductCategory.values())
                .filter(category -> category.lowerCase.equals(lowerCase))
                .findAny()
                .orElseThrow(() -> new NoCategoryFoundException("해당 카테고리가 없습니다."));
    }
}
