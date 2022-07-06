package yj.capstone.aerofarm.controller.admin;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import yj.capstone.aerofarm.dto.PageableList;
import yj.capstone.aerofarm.dto.response.MemberListResponseDto;
import yj.capstone.aerofarm.service.MemberService;


@Controller
@PreAuthorize("hasAnyAuthority('ADMIN')")
@RequiredArgsConstructor
public class AdminController {

    private final MemberService memberService;

    @GetMapping("/admin")
    public String adminPage() {
        return "admin/adminPage";
    }

    @GetMapping("/admin/members")
    public String memberList(Model model, @PageableDefault Pageable pageable) {
        Page<MemberListResponseDto> memberList = memberService.findMemberList(pageable);
        PageableList<MemberListResponseDto> pageableList = new PageableList<>(memberList);
        model.addAttribute("pageableList", pageableList);
        return "admin/memberListPage";
    }


}
