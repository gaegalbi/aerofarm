package yj.capstone.aerofarm.dto.response;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;

/**
 * 사용자가 주문할 때 주소를 받아오는 DTO
 */
@Getter
@Setter
public class OrderAddressResponseDto {
    private String address1;
    private String address2;
    private String extraAddress;
    private String zipcode;
    private String receiver;
    private String phoneNumber;

    @QueryProjection
    public OrderAddressResponseDto(String address1, String address2, String extraAddress, String zipcode, String receiver, String phoneNumber) {
        this.address1 = address1;
        this.address2 = address2;
        this.extraAddress = extraAddress;
        this.zipcode = zipcode;
        this.receiver = receiver;
        this.phoneNumber = phoneNumber;
    }
}
