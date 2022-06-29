package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.dto.*;
import yj.capstone.aerofarm.exception.NoCategoryFoundException;
import yj.capstone.aerofarm.service.ProductService;


@Controller
@RequiredArgsConstructor
@Slf4j
public class StoreController {

    private final ProductService productService;

    @GetMapping("/store")
    public String storeMain(Model model, String order, @PageableDefault Pageable pageable) {
        Page<ProductStoreInfoDto> productInfo = productService.findProductInfo(null, order, pageable);
        PageableList<ProductStoreInfoDto> pageableList = new PageableList<>(productInfo);
        model.addAttribute("pageableList", pageableList);
        model.addAttribute("category", "전체상품");
        return "store/storePage";
    }

    @GetMapping("/store/{category}")
    public String storeDevice(@PathVariable String category, Model model, @PageableDefault Pageable pageable) {
        ProductCategory productCategory = ProductCategory.findByLowerCase(category);
        Page<ProductStoreInfoDto> productInfo = productService.findProductInfo(productCategory, null, pageable);
        PageableList<ProductStoreInfoDto> pageableList = new PageableList<>(productInfo);
        model.addAttribute("pageableList", pageableList);
        model.addAttribute("category", productCategory.getName());

        return "store/storePage";
    }

    @GetMapping("/store/detail/{productId}")
    public String storeProductDetail(@PathVariable Long productId, @PageableDefault Pageable pageable, Model model) {
        Product product = productService.findProductById(productId);
        Page<StoreReviewDto> productReviews = productService.findProductReviews(productId, pageable);
        PageableList<StoreReviewDto> pageableList = new PageableList<>(productReviews);

        model.addAttribute("productId", productId);
        model.addAttribute("pageableList", pageableList);
        model.addAttribute("product", new ProductStoreDetailDto(product));
        return "store/productDetail";
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(NoCategoryFoundException.class)
    public String noCategoryFound(NoCategoryFoundException e) {
        return "forward:/store";
    }
}
