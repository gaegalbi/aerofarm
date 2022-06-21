package yj.capstone.aerofarm.repository;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.order.OrderLine;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.dto.CartDto;
import yj.capstone.aerofarm.dto.OrderInfoDto;
import yj.capstone.aerofarm.form.CheckoutForm;
import yj.capstone.aerofarm.form.SaveMemberForm;
import yj.capstone.aerofarm.form.SaveProductForm;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.*;

@SpringBootTest
@Transactional
class OrderRepositoryTest {

    @Autowired
    OrderRepository orderRepository;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    ProductRepository productRepository;

    @Test
    @DisplayName("주문 생성이 정상적으로 이뤄져야 한다.")
    void create_order_must_success() {
        SaveMemberForm saveMemberForm = new SaveMemberForm();
        saveMemberForm.setEmail("abc123@naver.com");
        saveMemberForm.setPassword("1234");
        saveMemberForm.setNickname("qqc");
        Member member = Member.saveMemberFormBuilder().saveMemberForm(saveMemberForm).build();
        memberRepository.save(member);

        List<OrderLine> orderLines = new ArrayList<>();
        CartDto cartDto1 = new CartDto(1L, 10);
        CartDto cartDto2 = new CartDto(2L, 5);
        Product product1 = Product.builder()
                .saveProductForm(new SaveProductForm("product1", 1000, 10, ProductCategory.ETC, null, null))
                .build();
        product1.changeImage("1");
        productRepository.save(product1);

        Product product2 = Product.builder()
                .saveProductForm(new SaveProductForm("product2", 2000, 5, ProductCategory.ETC, null, null))
                .build();
        product2.changeImage("2");
        productRepository.save(product2);

        orderLines.add(OrderLine.createOrderLine(product1, cartDto1));
        orderLines.add(OrderLine.createOrderLine(product2, cartDto2));

        CheckoutForm checkoutForm = CheckoutForm.builder()
                .address1("test")
                .address2("test")
                .deposit("NH")
                .paymentType("MOOTONGJANG")
                .phoneNumber("010-1111-1111")
                .extraAddress("test")
                .zipcode("12345")
                .saveAddress(false)
                .receiver("qqc")
                .build();

        Order order = Order.orderBuilder()
                .orderer(member)
                .checkoutForm(checkoutForm)
                .orderLines(orderLines)
                .build();
        orderRepository.save(order);

        PageRequest pageable = PageRequest.of(0, 10);
        Page<OrderInfoDto> orderInfoDto = orderRepository.findOrderInfoDto(pageable, 1L);

        for (OrderInfoDto infoDto : orderInfoDto) {
            System.out.println("infoDto = " + infoDto);
        }

        assertThat(orderInfoDto.getContent().size()).isEqualTo(1);
    }
}