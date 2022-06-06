package yj.capstone.aerofarm.domain.order;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Getter
@Embeddable
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Money {

    private int money;

    public Money(int price) {
        this.money = price;
    }

    public Money add(Money money) {
        return new Money(this.money + money.getMoney());
    }
}
