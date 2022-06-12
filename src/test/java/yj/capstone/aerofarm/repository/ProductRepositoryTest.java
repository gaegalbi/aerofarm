package yj.capstone.aerofarm.repository;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import yj.capstone.aerofarm.dto.ProductStoreInfoDto;
import yj.capstone.aerofarm.form.SaveProductForm;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.domain.product.ProductReview;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
class ProductRepositoryTest {

    @Autowired
    ProductRepository productRepository;

    @DisplayName("조회한 상점의 상품의 갯수가 맞아야 한다.")
    @Test
    void productInfoFind() {
        // given
        for (int i = 1; i <= 11; i++) {
            Product product = Product.builder()
                    .saveProductForm(new SaveProductForm("Product" + i, i * 100, i * 10, ProductCategory.ETC, null, null))
                    .build();
            productRepository.save(product);
        }

        //when
        PageRequest pageable = PageRequest.of(0, 10);
        Page<ProductStoreInfoDto> productInfo = productRepository.findProductInfo(ProductCategory.ETC, null, pageable);

        //then
        assertThat(productInfo.getContent().size()).isEqualTo(10);
        assertThat(productInfo.getTotalElements()).isEqualTo(11);
        assertThat(productInfo.getTotalPages()).isEqualTo(2);
    }

    @DisplayName("상점의 상품 리뷰 수와 평점이 맞아야 한다.")
    @Test
    void productInfoFind_reviewCount_reviewAvg() {
        // given
        Product product = Product.builder()
                .saveProductForm(new SaveProductForm("product", 1000, 10, ProductCategory.ETC, null, null))
                .build();

        ProductReview.builder()
                .product(product)
                .score(1)
                .review("TEST")
                .build();

        ProductReview.builder()
                .product(product)
                .score(2)
                .review("TEST")
                .build();

        ProductReview.builder()
                .product(product)
                .score(3)
                .review("TEST")
                .build();

        productRepository.save(product);

        // when
        PageRequest pageable = PageRequest.of(0, 2);
        Page<ProductStoreInfoDto> productInfo = productRepository.findProductInfo(ProductCategory.ETC, null, pageable);

        // then
        int size = productInfo.getContent().size();
        System.out.println("size = " + size);

        assertThat(productInfo.getContent().get(0).getReviewCnt()).isEqualTo(3);
        assertThat(productInfo.getContent().get(0).getScoreAvg()).isEqualTo(2);
    }
}