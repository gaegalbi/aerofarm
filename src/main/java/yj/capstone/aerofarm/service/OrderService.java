package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import yj.capstone.aerofarm.controller.dto.OrderLineDto;
import yj.capstone.aerofarm.controller.form.OrderForm;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.DeliveryStatus;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.order.OrderLine;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.repository.OrderRepository;
import yj.capstone.aerofarm.repository.ProductRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;

    // TODO
    public Order createOrder(Member orderer, OrderForm orderForm) {
        Order order = Order.orderBuilder()
                .orderer(orderer)
                .orderForm(orderForm)
                .build();

        List<OrderLine> orderLines = orderForm.getOrderLineDtos().stream()
                .map(this::createOrderLine)
                .collect(Collectors.toList());
        order.getOrderLines().addAll(orderLines);

        orderRepository.save(order);
        return order;
    }

    // TODO
    public OrderLine createOrderLine(OrderLineDto orderLineDto) {
        Product product = productRepository.findById(orderLineDto.getProductDto().getId()).orElseThrow(() -> new IllegalArgumentException("해당 상품이 없습니다."));
        return OrderLine.createOrderLine(orderLineDto, product);
    }

    // TODO
    public Order cancelOrder(Long orderId) {
        Order order = orderRepository.findById(orderId).orElseThrow(() -> new IllegalArgumentException("해당 주문이 없습니다."));
        DeliveryStatus deliveryStatus = order.cancel();
        // 물건 재고 수 다시 채우기
        if (deliveryStatus == DeliveryStatus.PAYMENT_OK) {
            // 주문 환불 처리
        }
        return order;
    }
}
