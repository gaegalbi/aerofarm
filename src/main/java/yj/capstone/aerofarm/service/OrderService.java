package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.dto.CartDto;
import yj.capstone.aerofarm.form.CheckoutForm;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.order.OrderLine;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.repository.OrderRepository;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class OrderService {

    private final OrderRepository orderRepository;
    private final ProductService productService;

    public Order createOrder(Member orderer, List<CartDto> cartDtos, CheckoutForm checkoutForm) {
        List<OrderLine> orderLines = new ArrayList<>();
        for (CartDto cartDto : cartDtos) {
            Product product = productService.findProductById(cartDto.getProductId());
            OrderLine orderLine = OrderLine.createOrderLine(product, cartDto);
            orderLines.add(orderLine);
        }

        Order order = Order.orderBuilder()
                .orderer(orderer)
                .checkoutForm(checkoutForm)
                .orderLines(orderLines)
                .build();

        return orderRepository.save(order);
    }

    public Long cancelOrder(String uuid) {
        Order order = orderRepository.findByUuid(uuid).orElseThrow(() -> new IllegalArgumentException("해당 주문이 없습니다."));
        order.cancel();

        List<OrderLine> orderLines = order.getOrderLines();
        // 물건 재고 수 다시 채우기
        for (OrderLine orderLine : orderLines) {
            Product product = productService.findProductById(orderLine.getId()); // 상품 주문 후 해당 상품이 없는 경우 추가 로직 작성
            product.increaseStock(orderLine.getQuantity());
        }

        return order.getId();
    }
}
