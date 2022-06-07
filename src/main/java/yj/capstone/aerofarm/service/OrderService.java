package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import yj.capstone.aerofarm.dto.OrderLineDto;
import yj.capstone.aerofarm.form.OrderForm;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.order.OrderLine;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.repository.OrderRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final ProductService productService;

    public Order createOrder(Member orderer, OrderForm orderForm) {
        List<OrderLine> orderLines = orderForm.getOrderLineDtos().stream()
                .map(this::createOrderLine)
                .collect(Collectors.toList());

        Order order = Order.orderBuilder()
                .orderer(orderer)
                .orderForm(orderForm)
                .orderLines(orderLines)
                .build();

        return orderRepository.save(order);
    }

    private OrderLine createOrderLine(OrderLineDto orderLineDto) {
        Product product = productService.findProduct(orderLineDto.getProductDto().getId());
        product.decreaseStock(orderLineDto.getQuantity());
        return OrderLine.createOrderLine(orderLineDto, product);
    }

    public Long cancelOrder(String uuid) {
        Order order = orderRepository.findByUuid(uuid).orElseThrow(() -> new IllegalArgumentException("해당 주문이 없습니다."));
        order.cancel();

        List<OrderLine> orderLines = order.getOrderLines();
        // 물건 재고 수 다시 채우기
        for (OrderLine orderLine : orderLines) {
            Product product = productService.findProduct(orderLine.getId()); // 상품 주문 후 해당 상품이 없는 경우 추가 로직 작성
            product.increaseStock(orderLine.getQuantity());
        }

        return order.getId();
    }
}
