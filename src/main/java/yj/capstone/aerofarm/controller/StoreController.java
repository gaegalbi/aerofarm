package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.dto.PageableList;
import yj.capstone.aerofarm.dto.ProductStoreDetailDto;
import yj.capstone.aerofarm.dto.ProductStoreInfoDto;
import yj.capstone.aerofarm.exception.NoCategoryFoundException;
import yj.capstone.aerofarm.service.ProductService;


@Controller
@RequiredArgsConstructor
@Slf4j
public class StoreController {

    private final ProductService productService;

    @GetMapping("/store")
    public String storeMain(Model model, String order, @RequestParam(defaultValue = "1") Integer page) {
        if (page < 1) {
            page = 1;
        }
        Page<ProductStoreInfoDto> productInfo = productService.findProductInfo(null, order, page);
        PageableList<ProductStoreInfoDto> pageableList = new PageableList<>(productInfo);
        model.addAttribute("pageableList", pageableList);
        model.addAttribute("category", "전체상품");
        return "store/storePage";
    }

    @GetMapping("/store/{category}")
    public String storeDevice(@PathVariable String category, @RequestParam(defaultValue = "1") Integer page, Model model) {
        if (page < 1) {
            page = 1;
        }

        try {
            ProductCategory productCategory = ProductCategory.findByLowerCase(category);
            Page<ProductStoreInfoDto> productInfo = productService.findProductInfo(productCategory, null, page);
            PageableList<ProductStoreInfoDto> pageableList = new PageableList<>(productInfo);
            model.addAttribute("pageableList", pageableList);
            model.addAttribute("category", productCategory.getName());
        } catch (NoCategoryFoundException e) {
            return "redirect:/store";
        }

        return "store/storePage";
    }

    @GetMapping("/store/detail/{productId}")
    public String storeProductDetail(@PathVariable Long productId, @RequestHeader(required = false, defaultValue = "/") String referer, Model model) {
        Product product = productService.findProductById(productId);
        model.addAttribute("previousPage", referer);
        model.addAttribute("product", new ProductStoreDetailDto(product));
        return "store/productDetail";
    }
}
