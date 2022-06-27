package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.dto.ErrorResponse;
import yj.capstone.aerofarm.dto.Message;
import yj.capstone.aerofarm.dto.ProductReviewDtos;
import yj.capstone.aerofarm.service.OrderService;
import yj.capstone.aerofarm.service.ProductService;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    private final ProductService productService;
    private final OrderService orderService;

    @PostMapping("/product/review")
    @ResponseBody
    public ResponseEntity<Message> createReview(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody ProductReviewDtos reviews) {
        orderService.reviewOrder(reviews.getOrderUuid(), userDetails.getMember());
        productService.createReview(reviews.getReviews(), userDetails.getMember());
        return ResponseEntity.ok()
                .body(Message.createMessage("리뷰가 작성되었습니다."));
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(IllegalArgumentException.class)
    public ErrorResponse exceptionHandling(IllegalArgumentException e) {
        return new ErrorResponse(e.getMessage());
    }
}
