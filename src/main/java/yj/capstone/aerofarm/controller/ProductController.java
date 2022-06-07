package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import yj.capstone.aerofarm.form.SaveProductForm;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.service.ProductService;

import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ProductController {

    private final ProductService productService;

    @GetMapping("/product/save")
    @PreAuthorize("hasAnyAuthority('GUEST')") // TODO ADMIN
    public String saveProductForm(Model model) {
        model.addAttribute("saveProductForm", new SaveProductForm());
        return "/product/saveProductPage";
    }

    @PostMapping("/product/save")
    @PreAuthorize("hasAnyAuthority('GUEST')") // TODO ADMIN
    public String saveProduct(@Valid SaveProductForm saveProductForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            log.debug("errors={} ", bindingResult);
            return "/product/saveProductPage";
        }

        Product product = productService.save(saveProductForm);
        log.info("product {} created",product.getId());
        return "redirect:/product/save";
    }
}
