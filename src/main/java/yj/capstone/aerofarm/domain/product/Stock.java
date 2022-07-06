package yj.capstone.aerofarm.domain.product;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Getter
@Embeddable
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Stock {
    private int stock;

    public Stock(int stock) {
        this.stock = stock;
    }

    public Stock decreaseStock(int quantity) {
        return new Stock(stock - quantity);
    }

    public Stock increaseStock(int quantity) {
        return new Stock(stock + quantity);
    }
}
