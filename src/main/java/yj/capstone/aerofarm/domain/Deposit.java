package yj.capstone.aerofarm.domain;

import lombok.Getter;

@Getter
public enum Deposit {
    NH("123-1234-1234-12"),
    SHINHAN("123-1234-1234-12"),
    DAEGU("123-1234-1234-12"),
    KUKMIN("123-1234-1234-12");

    private final String accountNumber;

    Deposit(String accountNumber) {
        this.accountNumber = accountNumber;
    }
}
