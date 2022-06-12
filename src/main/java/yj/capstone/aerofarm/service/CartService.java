package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.dto.CartDto;
import yj.capstone.aerofarm.dto.ProductCartDto;
import yj.capstone.aerofarm.repository.ProductRepository;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CartService {

    private final ProductRepository productRepository;

    public List<ProductCartDto> createProductCartDtos(List<CartDto> cartDtos) {
        List<ProductCartDto> productCartDtos = new ArrayList<>();
        for (CartDto cartDto : cartDtos) {
            Product product = productRepository.findById(cartDto.getProductId()).orElseThrow(() -> new IllegalArgumentException("해당 상품이 없습니다."));
            productCartDtos.add(new ProductCartDto(product, product.getPrice().getMoney(), cartDto.getQuantity()));
        }
        return productCartDtos;
    }
}
