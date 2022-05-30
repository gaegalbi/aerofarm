package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import yj.capstone.aerofarm.controller.form.SaveProductForm;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.repository.ProductRepository;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    public Product save(SaveProductForm saveProductForm) {
        Product product = Product.builder()
                .saveProductForm(saveProductForm)
                .build();
        return productRepository.save(product);
    }

    public Product findProduct(Long productId) {
        return productRepository.findById(productId).orElseThrow(() -> new IllegalArgumentException("해당 상품이 없습니다."));
    }
}
