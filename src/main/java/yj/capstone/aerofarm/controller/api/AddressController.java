package yj.capstone.aerofarm.controller.api;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.dto.response.OrderAddressResponseDto;
import yj.capstone.aerofarm.service.MemberService;

@RestController
@RequiredArgsConstructor
public class AddressController {
    private final MemberService memberService;

    @GetMapping("/api/member/getAddress")
    public OrderAddressResponseDto getAddress(@AuthenticationPrincipal UserDetailsImpl userDetails) {
        return memberService.findMemberAddress(userDetails.getMember().getId());
    }
}
