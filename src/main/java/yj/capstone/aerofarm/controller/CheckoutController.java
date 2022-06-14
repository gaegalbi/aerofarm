package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.order.PaymentType;
import yj.capstone.aerofarm.dto.CartDto;
import yj.capstone.aerofarm.dto.CheckoutCompleteDto;
import yj.capstone.aerofarm.dto.ProductCartDto;
import yj.capstone.aerofarm.form.CheckoutForm;
import yj.capstone.aerofarm.service.CartService;
import yj.capstone.aerofarm.service.OrderService;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('GUEST')")
@Slf4j
public class CheckoutController {

    private final CartService cartService;
    private final OrderService orderService;

    @ModelAttribute("checkoutForm")
    public CheckoutForm checkoutForm() {
        return new CheckoutForm("MOOTONGJANG");
    }

    @GetMapping("/checkout")
    public String checkoutPage(@SessionAttribute List<CartDto> cart, @AuthenticationPrincipal UserDetailsImpl userDetails, Model model) {
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
    public String checkout(@SessionAttribute List<CartDto> cart, @Valid @ModelAttribute CheckoutForm checkoutForm, BindingResult bindingResult, @AuthenticationPrincipal UserDetailsImpl userDetails, RedirectAttributes redirectAttributes) {
        if (cart == null || cart.isEmpty()) {
            return "redirect:/";
        }
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.checkoutForm", bindingResult);
            redirectAttributes.addFlashAttribute("checkoutForm", checkoutForm);
            return "redirect:/checkout";
        }

        try {
            Order order = orderService.createOrder(userDetails.getMember(), cart, checkoutForm);
            log.info("Order {} create. by {}", order.getId(), userDetails.getUsername());
            return "redirect:/checkout/" + order.getUuid();
        } catch (IllegalArgumentException e) {
            log.info("Order fail, out of stock. by {}", userDetails.getUsername());
        }
        return "redirect:/store";
    }

    @GetMapping("/checkout/{uuid}")
    public String checkoutComplete(@PathVariable String uuid, Model model) {
        try {
            Order order = orderService.findByUuid(uuid);
            CheckoutCompleteDto checkoutCompleteDto = new CheckoutCompleteDto();

            // TODO 조회용 쿼리 따로 만들어 처리할 것
            List<ProductCartDto> collect = order.getOrderLines().stream()
                    .map(ProductCartDto::new)
                    .collect(Collectors.toList());
            checkoutCompleteDto.getProductCartDtos().addAll(collect);

            checkoutCompleteDto.setOrderId(order.getId());
            checkoutCompleteDto.setReceiver(order.getReceiver().getReceiver());
            checkoutCompleteDto.setPhoneNumber(order.getReceiver().getPhoneNumber());
            checkoutCompleteDto.setPaymentType(order.getPaymentType());
            checkoutCompleteDto.setAddress1(order.getAddressInfo().getAddress1());
            checkoutCompleteDto.setAddress2(order.getAddressInfo().getAddress2());
            checkoutCompleteDto.setExtraAddress(order.getAddressInfo().getExtraAddress());
            checkoutCompleteDto.setZipcode(order.getAddressInfo().getZipcode());

            model.addAttribute("checkoutCompleteDto", checkoutCompleteDto);
            model.addAttribute("totalPrice", order.getTotalPrice().getMoney());
            model.addAttribute("deliveryPrice", 2500);

        } catch (IllegalArgumentException e) {
            return "redirect:/";
        }
        return "checkout/checkoutCompletePage";
    }
}
