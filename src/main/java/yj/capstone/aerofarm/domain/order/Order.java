package yj.capstone.aerofarm.domain.order;

import lombok.*;
import yj.capstone.aerofarm.form.CheckoutForm;
import yj.capstone.aerofarm.domain.AddressInfo;
import yj.capstone.aerofarm.domain.BaseEntity;
import yj.capstone.aerofarm.domain.member.Member;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "orders")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Order extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderLine> orderLines = new ArrayList<>();

    @Embedded
    private Money totalPrice;

    private String uuid = UUID.randomUUID().toString();

    @Enumerated(EnumType.STRING)
    private DeliveryStatus deliveryStatus = DeliveryStatus.PAYMENT_WAITING;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member orderer;

    @Embedded
    private AddressInfo addressInfo;

    @Enumerated(EnumType.STRING)
    private PaymentType paymentType;

    @Builder(builderClassName = "OrderBuilder", builderMethodName = "orderBuilder")
    public Order(CheckoutForm checkoutForm, Member orderer, List<OrderLine> orderLines) {
        this.addressInfo = new AddressInfo(
                checkoutForm.getReceiver(),
                checkoutForm.getPhoneNumber(),
                checkoutForm.getAddress1(),
                checkoutForm.getAddress2(),
                checkoutForm.getExtraAddress(),
                checkoutForm.getZipcode());
        this.orderer = orderer;
        this.paymentType = PaymentType.valueOf(checkoutForm.getPaymentType());
        setOrderLines(orderLines);
    }

    private void setOrderLines(List<OrderLine> orderLines) {
        for (OrderLine orderLine : orderLines) {
            orderLine.setOrder(this);
        }
        this.orderLines.addAll(orderLines);
        calculateTotalPrice();
    }

    private void calculateTotalPrice() {
        int sum = orderLines.stream()
                .mapToInt(OrderLine::getOrderPrice)
                .sum();
        this.totalPrice = new Money(sum);
    }

    public DeliveryStatus cancel() {
        DeliveryStatus deliveryStatus = this.deliveryStatus;
        if (this.deliveryStatus == DeliveryStatus.PAYMENT_WAITING) {
            this.deliveryStatus = DeliveryStatus.CANCELED;
            return deliveryStatus;
        }

        if (this.deliveryStatus == DeliveryStatus.PAYMENT_OK) {
            // 환불 로직 수행
            return deliveryStatus;
        }

        throw new IllegalArgumentException("배송 시작 후에는 취소가 불가능 합니다."); // TODO 예외 이름 변경
    }
}
