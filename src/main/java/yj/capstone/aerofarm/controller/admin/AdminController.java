package yj.capstone.aerofarm.controller.admin;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import yj.capstone.aerofarm.service.ProductService;

@Controller
@RequiredArgsConstructor
public class AdminController {
    private final ProductService productService;

    @PostMapping("/admin/product/delete/{productId}")
    public String deleteProduct(@PathVariable Long productId) {
        productService.deleteProduct(productId); // TODO 이미 주문이 있는 상품에 대해 softDelete 할 것!!!
        return "redirect:/store";
    }
}
