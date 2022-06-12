package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import yj.capstone.aerofarm.dto.CartDto;
import yj.capstone.aerofarm.dto.ProductCartDto;
import yj.capstone.aerofarm.service.CartService;

import java.util.ArrayList;
import java.util.List;

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

    @PutMapping("/cart")
    @ResponseBody
    public Boolean productToCart(@RequestBody CartDto cartDto, @ModelAttribute("cart") List<CartDto> cart) {
        for (CartDto inCart : cart) {
            if (inCart.getProductId().equals(cartDto.getProductId())) {
                return false;
            }
        }
        cart.add(cartDto);
        return true;
    }

    @DeleteMapping("/cart")
    @ResponseBody
    public Boolean deleteCart(@RequestBody CartDto cartDto, @ModelAttribute("cart") List<CartDto> cart) {
        return cart.removeIf(inCart -> inCart.getProductId().equals(cartDto.getProductId()));
    }

    @ResponseBody
    @PostMapping("/cart/clear")
    public boolean clearCart(SessionStatus sessionStatus) {
        sessionStatus.setComplete();
        return true;
    }
}
