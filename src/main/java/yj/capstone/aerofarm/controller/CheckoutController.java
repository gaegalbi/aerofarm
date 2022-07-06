package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.dto.*;
import yj.capstone.aerofarm.exception.OrderNotFoundException;
import yj.capstone.aerofarm.form.CheckoutForm;
import yj.capstone.aerofarm.service.CartService;
import yj.capstone.aerofarm.service.OrderService;

import javax.validation.Valid;
import java.util.List;

import static yj.capstone.aerofarm.dto.Message.createMessage;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('GUEST')")
@Slf4j
public class CheckoutController {

    private final CartService cartService;
    private final OrderService orderService;

    @GetMapping("/checkout")
    public String checkoutPage(@SessionAttribute List<CartDto> cart, Model model) {
        if (cart.isEmpty()) {
            return "redirect:/";
        }

        List<ProductCartDto> cartDtos = cartService.createProductCartDtos(cart);

        int totalPrice = cartDtos.stream()
                .mapToInt(ProductCartDto::getPrice)
                .sum();

        model.addAttribute("cartDtos", cartDtos);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("deliveryPrice", 2500);

        return "checkout/checkoutPage";
    }

    @PostMapping("/checkout")
    @ResponseBody
    public ResponseEntity<Message> checkout(@SessionAttribute List<CartDto> cart, @RequestBody @Valid CheckoutForm checkoutForm, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        if (cart == null || cart.isEmpty()) {
            throw new IllegalStateException("장바구니가 비어있습니다.");
        }
        Order order = orderService.createOrder(userDetails.getMember(), cart, checkoutForm);
        return ResponseEntity.ok()
                .body(createMessage(order.getUuid()));
    }

    @GetMapping("/checkout/{uuid}")
    public String checkoutComplete(@PathVariable String uuid, Model model) {
        try {
            Order order = orderService.findByUuid(uuid);
            CheckoutCompleteDto checkoutCompleteDto = orderService.createOrderDetail(order);

            model.addAttribute("checkoutCompleteDto", checkoutCompleteDto);
            model.addAttribute("totalPrice", order.getTotalPrice().getMoney());
            model.addAttribute("deliveryPrice", 2500);

        } catch (OrderNotFoundException e) {
            return "redirect:/";
        }
        return "checkout/checkoutCompletePage";
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(IllegalArgumentException.class)
    public ErrorResponse exceptionHandler(IllegalArgumentException e) {
        return new ErrorResponse("잘못된 요청입니다.");
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(IllegalStateException.class)
    public ErrorResponse exceptionHandler2(IllegalStateException e) {
        return new ErrorResponse(e.getMessage());
    }
}
