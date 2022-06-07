package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import yj.capstone.aerofarm.dto.ProductStoreInfoDto;
import yj.capstone.aerofarm.form.SaveProductForm;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.repository.ProductRepository;

import java.util.List;

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

    public List<Product> findAll() {
        return productRepository.findAll();
    }

    public Page<ProductStoreInfoDto> findProductInfo(String order, Integer page) {
        // Page가 0부터 시작하기 때문에 -1 해줌
        PageRequest pageRequest = PageRequest.of(page - 1, 10);
        return productRepository.findProductInfo(order, pageRequest);
    }
}
