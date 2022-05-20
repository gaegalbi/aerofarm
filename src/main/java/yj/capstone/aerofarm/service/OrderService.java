package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import yj.capstone.aerofarm.controller.form.OrderForm;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.DeliveryStatus;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.repository.OrderRepository;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;

    // TODO
    public Order createOrder(Member orderer, OrderForm orderForm) {
        return null;
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
