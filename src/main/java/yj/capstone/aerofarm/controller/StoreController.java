package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.controller.dto.PageableList;
import yj.capstone.aerofarm.controller.dto.ProductInfoDto;
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
        Page<ProductInfoDto> productInfo = productService.findProductInfo(order, page);
        PageableList<ProductInfoDto> pageableList = new PageableList<>(productInfo);
        model.addAttribute("pageableList", pageableList);
        return "/store/storePage";
    }
}
