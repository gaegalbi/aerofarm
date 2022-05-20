package yj.capstone.aerofarm.domain.order;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Getter
@Embeddable
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Money {

    private int price;

    public Money(int price) {
        this.price = price;
    }

    public Money add(Money money) {
        return new Money(this.price + money.getPrice());
    }
}
