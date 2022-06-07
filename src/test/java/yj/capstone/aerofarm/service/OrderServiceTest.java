package yj.capstone.aerofarm.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import yj.capstone.aerofarm.dto.OrderLineDto;
import yj.capstone.aerofarm.dto.ProductDto;
import yj.capstone.aerofarm.form.OrderForm;
import yj.capstone.aerofarm.form.SaveMemberForm;
import yj.capstone.aerofarm.form.SaveProductForm;
import yj.capstone.aerofarm.domain.AddressInfo;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.domain.product.ProductCategory;
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

    OrderService orderService;

    @BeforeEach
    public void before() {
        orderService = new OrderService(orderRepository, productService);
    }

    @Test
    @DisplayName("주문 생성")
    void create_order() {
        // given
        SaveMemberForm saveMemberForm = new SaveMemberForm();
        saveMemberForm.setEmail("abc123@naver.com");
        saveMemberForm.setPassword("1234");
        saveMemberForm.setPhoneNumber("010-1234-1234");
        saveMemberForm.setNickname("qqc");
        Member member = Member.saveMemberFormBuilder().saveMemberForm(saveMemberForm).build();

        Product product = new Product(new SaveProductForm("Apple", 1000, 100, ProductCategory.ETC));

        List<OrderLineDto> orderLineDtoList = new ArrayList<>();
        orderLineDtoList.add(new OrderLineDto(new ProductDto(product), 5, 1000));

        OrderForm orderForm = new OrderForm();
        orderForm.setOrderLineDtos(orderLineDtoList);
        orderForm.setAddressInfo(new AddressInfo("홍길동","seoul", "seoul", "12345"));

        // when
        when(orderRepository.save(any(Order.class))).then(returnsFirstArg());
        when(productService.findProduct(any())).thenReturn(product);
        Order order = orderService.createOrder(member, orderForm);

        // then
        assertThat(order.getOrderer()).isEqualTo(member);
        assertThat(product.getStock().getStock()).isEqualTo(95);
        assertThat(order.getTotalPrice().getMoney()).isEqualTo(5000);
    }

    @Test
    @DisplayName("주문 수량이 재고보다 많으면 실패해야 한다.")
    void create_order_over_quantity() {
        // given
        Product product = new Product(new SaveProductForm("Apple", 1000, 100, ProductCategory.ETC));

        List<OrderLineDto> orderLineDtoList = new ArrayList<>();
        orderLineDtoList.add(new OrderLineDto(new ProductDto(product), 101, 5000));

        OrderForm orderForm = new OrderForm();
        orderForm.setOrderLineDtos(orderLineDtoList);
        orderForm.setAddressInfo(new AddressInfo("홍길동","seoul", "seoul", "12345"));

        // when
        when(productService.findProduct(any())).thenReturn(product);

        // then
        assertThatThrownBy(() -> orderService.createOrder(null, orderForm)).isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    @DisplayName("주문 취소 시 재고가 다시 늘어나야 한다.")
    void cancel_order_must_rollback_quantity() {
        // given
        Product product = new Product(new SaveProductForm("Apple", 1000, 100, ProductCategory.ETC));

        List<OrderLineDto> orderLineDtoList = new ArrayList<>();
        orderLineDtoList.add(new OrderLineDto(new ProductDto(product), 5, 5000));

        OrderForm orderForm = new OrderForm();
        orderForm.setOrderLineDtos(orderLineDtoList);
        orderForm.setAddressInfo(new AddressInfo("홍길동","seoul", "seoul", "12345"));

        when(productService.findProduct(any())).thenReturn(product);
        when(orderRepository.save(any(Order.class))).then(returnsFirstArg());

        Order order = orderService.createOrder(null, orderForm);
        when(orderRepository.findByUuid(any())).thenReturn(Optional.ofNullable(order));
        // when
        orderService.cancelOrder(order.getUuid());

        // then
        assertThat(product.getStock().getStock()).isEqualTo(100);
    }
}