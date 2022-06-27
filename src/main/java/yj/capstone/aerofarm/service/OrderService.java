package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.order.OrderLine;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.dto.CartDto;
import yj.capstone.aerofarm.dto.CheckoutCompleteDto;
import yj.capstone.aerofarm.dto.OrderInfoDto;
import yj.capstone.aerofarm.dto.ProductCartDto;
import yj.capstone.aerofarm.form.CheckoutForm;
import yj.capstone.aerofarm.repository.OrderRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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

    public Page<OrderInfoDto> findOrderInfoByMemberId(Long memberId, Pageable pageable) {
        return orderRepository.findOrderInfoDto(pageable, memberId);
    }

    public Order findByUuid(String uuid) {
        return orderRepository.findByUuid(uuid).orElseThrow(() -> new IllegalArgumentException("해당 주문이 없습니다."));
    }

    private boolean verifyOrderOwner(String uuid, Member member) {
        return orderRepository.existsByUuidAndOrderer(uuid, member);
    }

    public void reviewOrder(String uuid, Member member) {
        if (verifyOrderOwner(uuid, member)) {
            findByUuid(uuid).reviewed();
            return;
        }
        throw new IllegalArgumentException("해당 유저의 주문이 없습니다.");
    }

    public CheckoutCompleteDto createOrderDetail(Order order) {
        CheckoutCompleteDto checkoutCompleteDto = CheckoutCompleteDto.builder()
                .orderId(order.getId())
                .receiver(order.getReceiver().getReceiver())
                .phoneNumber(order.getReceiver().getPhoneNumber())
                .address1(order.getAddressInfo().getAddress1())
                .address2(order.getAddressInfo().getAddress2())
                .extraAddress(order.getAddressInfo().getExtraAddress())
                .zipcode(order.getAddressInfo().getZipcode())
                .paymentType(order.getPaymentType())
                .build();

        List<ProductCartDto> collect = order.getOrderLines().stream()
                .map(ProductCartDto::new)
                .collect(Collectors.toList());

        checkoutCompleteDto.getProductCartDtos().addAll(collect);

        return checkoutCompleteDto;
    }
}
