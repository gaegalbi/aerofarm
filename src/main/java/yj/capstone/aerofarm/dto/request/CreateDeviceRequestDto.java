package yj.capstone.aerofarm.dto.request;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Range;

@Getter
@Setter
public class CreateDeviceRequestDto {
    private String model;
    @Range(min = 1, max = 10)
    private int quantity;

    public CreateDeviceRequestDto() {
    }

    public CreateDeviceRequestDto(String model, int quantity) {
        this.model = model;
        this.quantity = quantity;
    }
}
