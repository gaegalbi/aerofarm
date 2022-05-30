package yj.capstone.aerofarm.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Embeddable
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class AddressInfo {
    private String receiver;
    private String address1;
    private String address2;
    private String zipcode;

    public AddressInfo(String receiver, String address1, String address2, String zipcode) {
        this.receiver = receiver;
        this.address1 = address1;
        this.address2 = address2;
        this.zipcode = zipcode;
    }

    public AddressInfo changeAddress(String receiver,String address1, String address2, String zipcode) {
        return new AddressInfo(receiver, address1, address2, zipcode);
    }
}
