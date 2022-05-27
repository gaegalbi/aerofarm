package yj.capstone.aerofarm.service;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.AdditionalAnswers;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import yj.capstone.aerofarm.controller.form.OrderForm;
import yj.capstone.aerofarm.controller.form.SaveMemberForm;
import yj.capstone.aerofarm.domain.AddressInfo;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.DeliveryStatus;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.order.PaymentType;
import yj.capstone.aerofarm.repository.OrderRepository;
import yj.capstone.aerofarm.repository.ProductRepository;

import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.AdditionalAnswers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

    @Mock
    OrderRepository orderRepository;
    @Mock
    ProductRepository productRepository;

    OrderService orderService;

    @BeforeEach
    public void before() {
        orderService = new OrderService(orderRepository, productRepository);
    }

    @Test
    @DisplayName("무통장으로 주문 생성")
    void create_order_with_mootongjang() {
        // given
        SaveMemberForm saveMemberForm = new SaveMemberForm();
        saveMemberForm.setEmail("abc123@naver.com");
        saveMemberForm.setPassword("1234");
        saveMemberForm.setPhoneNumber("010-1234-1234");
        saveMemberForm.setNickname("qqc");
        Member member = Member.saveMemberFormBuilder().saveMemberForm(saveMemberForm).build();

        OrderForm orderForm = new OrderForm();
        orderForm.setAddressInfo(new AddressInfo("seoul", "seoul", "12345"));
        orderForm.setPaymentType(PaymentType.MOOTONGJANG);
        orderForm.setReceiver("홍길동");

        // when
        when(orderRepository.save(any(Order.class))).then(returnsFirstArg());
        Order order = orderService.createOrder(member, orderForm);

        // then
        assertThat(order.getOrderer()).isEqualTo(member);
        assertThat(order.getPaymentType()).isEqualTo(PaymentType.MOOTONGJANG);
        assertThat(order.getDeliveryStatus()).isEqualTo(DeliveryStatus.PAYMENT_WAITING);
    }

    @Test
    @DisplayName("신용카드로 주문 생성")
    void create_order_with_credit_card() {
        // given
        SaveMemberForm saveMemberForm = new SaveMemberForm();
        saveMemberForm.setEmail("abc123@naver.com");
        saveMemberForm.setPassword("1234");
        saveMemberForm.setPhoneNumber("010-1234-1234");
        saveMemberForm.setNickname("qqc");
        Member member = Member.saveMemberFormBuilder().saveMemberForm(saveMemberForm).build();

        OrderForm orderForm = new OrderForm();
        orderForm.setAddressInfo(new AddressInfo("seoul", "seoul", "12345"));
        orderForm.setPaymentType(PaymentType.CREDIT_CARD);
        orderForm.setReceiver("홍길동");

        // when
        when(orderRepository.save(any(Order.class))).then(returnsFirstArg());
        Order order = orderService.createOrder(member, orderForm);

        // then
        assertThat(order.getOrderer()).isEqualTo(member);
        assertThat(order.getPaymentType()).isEqualTo(PaymentType.CREDIT_CARD);
        assertThat(order.getDeliveryStatus()).isEqualTo(DeliveryStatus.PAYMENT_OK);
    }
}