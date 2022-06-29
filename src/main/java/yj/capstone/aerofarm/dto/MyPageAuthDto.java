package yj.capstone.aerofarm.dto;

import lombok.Setter;

@Setter
public class MyPageAuthDto {
    private Boolean verify;

    public MyPageAuthDto() {
        this.verify = false;
    }

    public boolean isVerify() {
        return this.verify;
    }
}
