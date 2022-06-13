package yj.capstone.aerofarm.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.AddressInfo;
import yj.capstone.aerofarm.domain.member.Member;

@Setter
@Getter
public class MemberDto {

    private String email;
    private String nickname;
    private String picture;
    private String phoneNumber;
    private AddressInfo addressInfo;

    public MemberDto() {
    }

    @Builder
    public MemberDto(String email, String nickname, String picture, String phoneNumber, AddressInfo addressInfo) {
        this.email = email;
        this.nickname = nickname;
        this.picture = picture;
        this.phoneNumber = phoneNumber;
        this.addressInfo = addressInfo;
    }
}
