package yj.capstone.aerofarm.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

    @GetMapping("/memberInfo")
    @PreAuthorize("hasAnyRole('NORMAL')")
    public String memberInfo() {
        return "member/memberInfo";
    }

    @GetMapping("/memberInfo2")
    @PreAuthorize("hasAnyRole('GUEST')")
    public String memberInfo2() {
        return "member/memberInfo";
    }
}
