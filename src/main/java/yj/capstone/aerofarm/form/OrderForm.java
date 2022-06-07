package yj.capstone.aerofarm.form;

import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.dto.OrderLineDto;
import yj.capstone.aerofarm.domain.AddressInfo;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class OrderForm {
    private AddressInfo addressInfo;
    private List<OrderLineDto> orderLineDtos = new ArrayList<>();
}
