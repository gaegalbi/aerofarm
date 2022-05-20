package yj.capstone.aerofarm.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

    @GetMapping("/memberInfo")
    @PreAuthorize("hasAnyAuthority('GUEST')")
    public String memberInfo() {
        return "member/memberInfo";
    }
}
