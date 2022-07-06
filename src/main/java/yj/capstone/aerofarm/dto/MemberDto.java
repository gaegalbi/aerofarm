package yj.capstone.aerofarm.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.AddressInfo;

@Setter
@Getter
public class MemberDto {

    private String email;
    private String nickname;
    private String picture;
    private String phoneNumber;
    private AddressInfo addressInfo;
    private String name;

    public MemberDto() {
    }

    @Builder
    public MemberDto(String email, String nickname, String picture, String phoneNumber, AddressInfo addressInfo, String name) {
        this.email = email;
        this.nickname = nickname;
        this.picture = picture;
        this.phoneNumber = phoneNumber;
        this.addressInfo = addressInfo;
        this.name = name;
    }
}
