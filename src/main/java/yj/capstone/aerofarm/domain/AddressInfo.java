package yj.capstone.aerofarm.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Embeddable;
import javax.validation.constraints.Pattern;

@Embeddable
@Getter
@NoArgsConstructor
public class AddressInfo {
    private String address1;
    private String address2;
    private String extraAddress;
    @Pattern(regexp = "^[0-9-]*$", message = "올바른 우편번호를 입력해주세요.")
    @Length(min = 5, max = 7, message = "올바른 우편번호를 입력해주세요.")
    private String zipcode;

    @Builder
    public AddressInfo(String address1, String address2, String extraAddress, String zipcode) {
        this.address1 = address1;
        this.address2 = address2;
        this.extraAddress = extraAddress;
        this.zipcode = zipcode;
    }
}
