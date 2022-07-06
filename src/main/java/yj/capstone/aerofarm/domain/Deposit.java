package yj.capstone.aerofarm.domain;

import lombok.Getter;

@Getter
public enum Deposit {
    NH("농협","홍길동","123-1234-1234-12"),
    SHINHAN("신한은행","홍길동","123-1234-1234-12"),
    DAEGU("대구은행","홍길동","123-1234-1234-12"),
    KUKMIN("국민은행","홍길동","123-1234-1234-12");

    private final String bank;
    private final String depositor;
    private final String accountNumber;

    Deposit(String bank, String depositor, String accountNumber) {
        this.bank = bank;
        this.depositor = depositor;
        this.accountNumber = accountNumber;
    }
}
