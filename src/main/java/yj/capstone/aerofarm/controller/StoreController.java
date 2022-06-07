package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.dto.PageableList;
import yj.capstone.aerofarm.dto.ProductStoreInfoDto;
import yj.capstone.aerofarm.service.ProductService;


@Controller
@RequiredArgsConstructor
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

    @GetMapping("/store/device")
    public String storeDevice(Model model, String order, @RequestParam(defaultValue = "1") Integer page) {
        if (page < 1) {
            page = 1;
        }
        Page<ProductStoreInfoDto> productInfo = productService.findProductInfo(ProductCategory.DEVICE, order, page);
        PageableList<ProductStoreInfoDto> pageableList = new PageableList<>(productInfo);
        model.addAttribute("pageableList", pageableList);
        model.addAttribute("category", "기기");
        return "store/storePage";
    }

    @GetMapping("/store/seed")
    public String storeSeed(Model model, String order, @RequestParam(defaultValue = "1") Integer page) {
        if (page < 1) {
            page = 1;
        }
        Page<ProductStoreInfoDto> productInfo = productService.findProductInfo(ProductCategory.SEED, order, page);
        PageableList<ProductStoreInfoDto> pageableList = new PageableList<>(productInfo);
        model.addAttribute("pageableList", pageableList);
        model.addAttribute("category", "씨앗");
        return "store/storePage";
    }

    @GetMapping("/store/fertilizer")
    public String storeFertilizer(Model model, String order, @RequestParam(defaultValue = "1") Integer page) {
        if (page < 1) {
            page = 1;
        }
        Page<ProductStoreInfoDto> productInfo = productService.findProductInfo(ProductCategory.FERTILIZER, order, page);
        PageableList<ProductStoreInfoDto> pageableList = new PageableList<>(productInfo);
        model.addAttribute("pageableList", pageableList);
        model.addAttribute("category", "양액");
        return "store/storePage";
    }

    @GetMapping("/store/etc")
    public String storeEtc(Model model, String order, @RequestParam(defaultValue = "1") Integer page) {
        if (page < 1) {
            page = 1;
        }
        Page<ProductStoreInfoDto> productInfo = productService.findProductInfo(ProductCategory.ETC, order, page);
        PageableList<ProductStoreInfoDto> pageableList = new PageableList<>(productInfo);
        model.addAttribute("pageableList", pageableList);
        model.addAttribute("category", "기타");
        return "store/storePage";
    }

    @GetMapping("/store/{productId}")
    public String storeProductDetail(@PathVariable Long productId, Model model) {
        return "index";
    }

    @GetMapping("/stores")
    @ResponseBody
    public Page<ProductStoreInfoDto> test() {
        return productService.findProductInfo(null,null, 1);
    }
}
