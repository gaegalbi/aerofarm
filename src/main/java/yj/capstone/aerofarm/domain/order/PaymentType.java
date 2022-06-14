package yj.capstone.aerofarm.domain.order;

import lombok.Getter;

@Getter
public enum PaymentType {
    MOOTONGJANG("무통장입금"),
    CREDIT_CARD("신용카드"),
    KAKAOPAY("카카오페이"),
    TOSS("토스");

    private final String korName;

    PaymentType(String korName) {
        this.korName = korName;
    }

    @Override
    public String toString() {
        return korName;
    }
}
