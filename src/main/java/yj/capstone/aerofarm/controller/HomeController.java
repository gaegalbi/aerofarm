package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import yj.capstone.aerofarm.dto.MemberDto;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.TestDto;
import yj.capstone.aerofarm.dto.request.DeviceConnInfoRequestDto;

@Slf4j
@Controller
@RequiredArgsConstructor
public class HomeController {

    @GetMapping("/")
    public String home(Model model, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        if (userDetails != null) {
            Member member = userDetails.getMember();
            MemberDto memberDto = MemberDto.builder()
                    .nickname(member.getNickname())
                    .picture(member.getPicture())
                    .build();
            model.addAttribute("memberDto", memberDto);
        }
        return "index";
    }

    @PostMapping("/test")
    @ResponseBody
    public DeviceConnInfoRequestDto test(@RequestBody DeviceConnInfoRequestDto request) {
        log.info("{}",request);
        return request;
    }
}