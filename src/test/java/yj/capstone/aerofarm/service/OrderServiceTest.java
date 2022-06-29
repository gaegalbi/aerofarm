package yj.capstone.aerofarm.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import yj.capstone.aerofarm.dto.CartDto;
import yj.capstone.aerofarm.dto.request.SignupRequest;
import yj.capstone.aerofarm.form.CheckoutForm;
import yj.capstone.aerofarm.form.SaveProductForm;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.repository.MooTongJangRepository;
import yj.capstone.aerofarm.repository.OrderRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.AdditionalAnswers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

    @Mock
    OrderRepository orderRepository;
    @Mock
    ProductService productService;
    @Mock
    MooTongJangRepository mooTongJangRepository;

    OrderService orderService;

    @BeforeEach
    public void before() {
        orderService = new OrderService(orderRepository, productService, mooTongJangRepository);
    }

    @Test
    @DisplayName("주문이 생성되면 재고가 줄어들어야 한다")
    void create_order() {
        // given
        SignupRequest saveMemberForm = new SignupRequest();
        saveMemberForm.setEmail("abc123@naver.com");
        saveMemberForm.setPassword("1234");
        saveMemberForm.setNickname("qqc");
        Member member = Member.builder()
                .build();
//                .saveMemberForm(saveMemberForm).build();

        Product product = new Product(new SaveProductForm("Apple", 1000, 100, ProductCategory.ETC, null, null));
        List<CartDto> cartDtos = new ArrayList<>();
        cartDtos.add(new CartDto(1L, 5));
        CheckoutForm checkoutForm = new CheckoutForm(true, "MOOTONGJANG", "jonedoe", "010-1111-1111", "seoul", "seoul", "apt", "12345", "NH");

        // when
        when(orderRepository.save(any(Order.class))).then(returnsFirstArg());
        when(productService.findProductById(any())).thenReturn(product);
        Order order = orderService.createOrder(member, cartDtos, checkoutForm);

        // then
        assertThat(order.getOrderer()).isEqualTo(member);
        assertThat(product.getStock().getStock()).isEqualTo(95);
        assertThat(order.getTotalPrice().getMoney()).isEqualTo(5000);
    }

    @Test
    @DisplayName("주문 수량이 재고보다 많으면 실패해야 한다.")
    void create_order_over_quantity() {
        // given
        Product product = new Product(new SaveProductForm("Apple", 1000, 100, ProductCategory.ETC, null, null));
        List<CartDto> cartDtos = new ArrayList<>();
        cartDtos.add(new CartDto(1L, 101));
        CheckoutForm checkoutForm = new CheckoutForm(true, "MOOTONGJANG", "jonedoe", "010-1111-1111", "seoul", "seoul", "apt", "12345", "NH");

        // when
        when(productService.findProductById(any())).thenReturn(product);

        // then
        assertThatThrownBy(() -> orderService.createOrder(null, cartDtos, checkoutForm)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    @DisplayName("주문 취소 시 재고가 다시 늘어나야 한다.")
    void cancel_order_must_rollback_quantity() {
        // given
        Product product = new Product(new SaveProductForm("Apple", 1000, 100, ProductCategory.ETC, null, null));

        List<CartDto> cartDtos = new ArrayList<>();
        cartDtos.add(new CartDto(1L, 5));
        CheckoutForm checkoutForm = new CheckoutForm(true, "MOOTONGJANG", "jonedoe", "010-1111-1111", "seoul", "seoul", "apt", "12345", "NH");

        when(orderRepository.save(any(Order.class))).then(returnsFirstArg());
        when(productService.findProductById(any())).thenReturn(product);
        Order order = orderService.createOrder(null, cartDtos, checkoutForm);

        when(orderRepository.findByUuid(any())).thenReturn(Optional.ofNullable(order));
        // when
        orderService.cancelOrder(order.getUuid());

        // then
        assertThat(product.getStock().getStock()).isEqualTo(100);
    }
}