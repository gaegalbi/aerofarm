package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import yj.capstone.aerofarm.dto.CartDto;
import yj.capstone.aerofarm.dto.Message;
import yj.capstone.aerofarm.dto.ProductCartDto;
import yj.capstone.aerofarm.service.CartService;

import java.util.ArrayList;
import java.util.List;

import static yj.capstone.aerofarm.dto.Message.createMessage;

@Controller
@SessionAttributes("cart")
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('GUEST')")
public class CartController {

    private final CartService cartService;

    @ModelAttribute("cart")
    public List<CartDto> setEmptyCart() {
        return new ArrayList<>();
    }

    @GetMapping("/cart")
    public String cart(@ModelAttribute("cart") List<CartDto> cart, Model model) {
        if (!cart.isEmpty()) {
            List<ProductCartDto> cartDtos = cartService.createProductCartDtos(cart);

            int totalPrice = cartDtos.stream()
                    .mapToInt(ProductCartDto::getPrice)
                    .sum();

            model.addAttribute("cartDtos", cartDtos);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("deliveryPrice", 2500);
        }
        return "cart/cartList";
    }

    @PostMapping("/cart")
    @ResponseBody
    public ResponseEntity<Message> productToCart(@RequestBody CartDto cartDto, @ModelAttribute("cart") List<CartDto> cart) {
        for (CartDto inCart : cart) {
            if (inCart.getProductId().equals(cartDto.getProductId())) {
                return ResponseEntity.status(HttpStatus.ACCEPTED)
                        .body(createMessage("상품이 이미 장바구니에 있습니다."));
            }
        }
        cart.add(cartDto);
        return ResponseEntity.ok()
                .body(createMessage("상품이 장바구니에 추가되었습니다."));
    }

    @DeleteMapping("/cart")
    @ResponseBody
    public ResponseEntity<Message> deleteCart(@RequestBody CartDto cartDto, @ModelAttribute("cart") List<CartDto> cart) {
        boolean result = cart.removeIf(inCart -> inCart.getProductId().equals(cartDto.getProductId()));
        if (result) {
            return ResponseEntity.ok()
                    .body(createMessage("장바구니에 상품이 제거되었습니다."));
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(createMessage("해당 상품이 장바구니에 없습니다."));
    }

    @PostMapping("/cart/clear")
    @ResponseBody
    public ResponseEntity<Message> clearCart(SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return ResponseEntity.ok()
                .body(createMessage("장바구니에 상품이 모두 지워졌습니다"));
    }
}
