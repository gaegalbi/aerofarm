package yj.capstone.aerofarm.form;

import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

@Setter
@Getter
@NoArgsConstructor
public class CheckoutForm {

    private boolean saveAddress;

    @NotBlank(message = "결재 수단을 선택해주세요.")
    private String paymentType;

    @NotBlank(message = "받는 사람의 이름을 입력해주세요.")
    private String receiver;

    @NotBlank(message = "받는 사람의 전화번호를 입력해주세요.")
    private String phoneNumber;

    @NotBlank(message = "주소를 입력해주세요.")
    private String address1;

    @NotBlank(message = "주소를 입력해주세요.")
    private String address2;

    private String extraAddress;

    @NotBlank(message = "우편번호를 입력해주세요.")
    @Pattern(regexp = "^[0-9-]*$", message = "올바른 우편번호를 입력해주세요.")
    private String zipcode;

    @NotBlank(message = "입금 계좌를 선택해주세요.")
    private String deposit;

    @Builder
    public CheckoutForm(boolean saveAddress, String paymentType, String receiver, String phoneNumber, String address1, String address2, String extraAddress, String zipcode, String deposit) {
        this.saveAddress = saveAddress;
        this.paymentType = paymentType;
        this.receiver = receiver;
        this.phoneNumber = phoneNumber;
        this.address1 = address1;
        this.address2 = address2;
        this.extraAddress = extraAddress;
        this.zipcode = zipcode;
        this.deposit = deposit;
    }

    // radio button 기본값 설정 위함
    public CheckoutForm(String paymentType) {
        this.paymentType = paymentType;
    }
}
