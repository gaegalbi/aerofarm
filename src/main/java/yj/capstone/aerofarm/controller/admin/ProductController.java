package yj.capstone.aerofarm.controller.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

    @GetMapping("/admin/product/save")
    @PreAuthorize("hasAnyAuthority('ADMIN')")
    public String saveProductForm(Model model) {
        model.addAttribute("saveProductForm", new SaveProductForm());
        return "product/saveProductPage";
    }

    @PostMapping("/admin/product/save")
    @PreAuthorize("hasAnyAuthority('ADMIN')")
    public String saveProduct(@Valid SaveProductForm saveProductForm, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "product/saveProductPage";
        }
        Product product = productService.save(saveProductForm);
        log.info("Product created, id = {}", product.getId());
        return "redirect:/admin/product/save?create=true";
    }

    @PostMapping("/admin/product/delete/{productId}")
    public String deleteProduct(@PathVariable Long productId) {
        productService.deleteProduct(productId); // TODO 이미 주문이 있는 상품에 대해 softDelete 할 것!!!
        log.info("Product created, id = {}", productId);
        return "redirect:/store";
    }
}
