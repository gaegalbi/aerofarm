package yj.capstone.aerofarm.domain.order;

import lombok.Getter;

@Getter
public enum DeliveryStatus {
    PAYMENT_WAITING("입금대기"),
    PAYMENT_OK("입금완료"),
    DELIVERY_READY("배송준비"),
    DELIVERING("배송중"),
    DELIVERED("배송완료"),
    CANCELED("주문취소");

    private final String korName;

    DeliveryStatus(String korName) {
        this.korName = korName;
    }

    @Override
    public String toString() {
        return korName;
    }
}
