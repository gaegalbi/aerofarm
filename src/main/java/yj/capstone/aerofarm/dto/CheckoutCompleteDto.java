package yj.capstone.aerofarm.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.order.PaymentType;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class CheckoutCompleteDto {

    private Long orderId;
    private String receiver;
    private String phoneNumber;
    private String zipcode;
    private String address1;
    private String address2;
    private String extraAddress;
    private PaymentType paymentType;
    private List<ProductCartDto> productCartDtos = new ArrayList<>();

    public CheckoutCompleteDto() {
    }

    @Builder
    public CheckoutCompleteDto(Long orderId,String receiver, String phoneNumber, String zipcode, String address1, String address2, String extraAddress, PaymentType paymentType) {
        this.orderId = orderId;
        this.receiver = receiver;
        this.phoneNumber = phoneNumber;
        this.zipcode = zipcode;
        this.address1 = address1;
        this.address2 = address2;
        this.extraAddress = extraAddress;
        this.paymentType = paymentType;
    }
}
