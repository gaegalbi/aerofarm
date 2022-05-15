package yj.capstone.aerofarm.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Embeddable
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AddressInfo {
    private String address1;
    private String address2;
    private String zipcode;

    public AddressInfo(String address1, String address2, String zipcode) {
        this.address1 = address1;
        this.address2 = address2;
        this.zipcode = zipcode;
    }

    public AddressInfo changeAddress(String address1, String address2, String zipcode) {
        return new AddressInfo(address1, address2, zipcode);
    }
}
