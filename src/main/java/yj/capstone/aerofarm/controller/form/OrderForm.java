package yj.capstone.aerofarm.controller.form;

import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.controller.dto.OrderLineDto;
import yj.capstone.aerofarm.domain.AddressInfo;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class OrderForm {

    private AddressInfo addressInfo;

    /**
     * MOOTONGJANG,
     * CREDIT_CARD,
     * KAKAOPAY,
     * TOSS
     */
    private String paymentType;

    private String receiver;
    private List<OrderLineDto> orderLineDtos = new ArrayList<>();
}
