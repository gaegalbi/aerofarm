package yj.capstone.aerofarm.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MyPageAuthDto {
    private Boolean verify;

    public MyPageAuthDto() {
        this.verify = false;
    }
}
