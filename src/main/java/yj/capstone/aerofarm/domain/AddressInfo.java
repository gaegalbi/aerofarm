package yj.capstone.aerofarm.domain;

import javax.persistence.Embeddable;

@Embeddable
public class AddressInfo {
    private String address1;
    private String address2;
    private String zipcode;
}
