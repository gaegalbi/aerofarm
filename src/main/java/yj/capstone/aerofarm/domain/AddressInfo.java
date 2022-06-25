package yj.capstone.aerofarm.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Embeddable
@Getter
@NoArgsConstructor
public class AddressInfo {
    private String address1;
    private String address2;
    private String extraAddress;
    private String zipcode;

    @Builder
    public AddressInfo(String address1, String address2, String extraAddress, String zipcode) {
        this.address1 = address1;
        this.address2 = address2;
        this.extraAddress = extraAddress;
        this.zipcode = zipcode;
    }
}
