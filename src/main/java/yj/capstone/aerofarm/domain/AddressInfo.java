package yj.capstone.aerofarm.domain;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Embeddable
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AddressInfo {
    private String receiver;
    private String phoneNumber;
    private String address1;
    private String address2;
    private String extraAddress;
    private String zipcode;
}
