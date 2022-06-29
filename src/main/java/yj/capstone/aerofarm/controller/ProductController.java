package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.product.ProductReview;
import yj.capstone.aerofarm.dto.Message;
import yj.capstone.aerofarm.dto.ProductReviewDto;
import yj.capstone.aerofarm.dto.ProductReviewDtos;
import yj.capstone.aerofarm.form.SaveProductForm;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.service.OrderService;
import yj.capstone.aerofarm.service.ProductService;

import javax.validation.Valid;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ProductController {

    private final ProductService productService;
    private final OrderService orderService;

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

    @PostMapping("/product/review")
    @ResponseBody
    public ResponseEntity<Message> createReview(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody ProductReviewDtos reviews) {
        try {
            orderService.reviewOrder(reviews.getOrderUuid(), userDetails.getMember());
            productService.createReview(reviews.getReviews(), userDetails.getMember());
            return ResponseEntity.ok()
                    .body(Message.createMessage("리뷰가 작성되었습니다."));
        } catch (IllegalArgumentException e) {
            log.info("잘못된 접근이 발생했습니다. by email = {}", userDetails.getUsername(), e);
        }
        return ResponseEntity.badRequest()
                .body(Message.createMessage("잘못된 접근입니다."));
    }
}
