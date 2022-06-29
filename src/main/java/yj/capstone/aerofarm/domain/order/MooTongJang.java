package yj.capstone.aerofarm.domain.order;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.domain.Deposit;

import javax.persistence.*;

/**
 * 무통장 거래 전용 특수 엔티티
 */
@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class MooTongJang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;

    @Enumerated(EnumType.STRING)
    private Deposit deposit;

    public static MooTongJang createMooTongJang(Order order, String deposit) {
        return new MooTongJang(order, Deposit.valueOf(deposit));
    }

    private MooTongJang(Order order, Deposit deposit) {
        this.order = order;
        this.deposit = deposit;
    }
}
