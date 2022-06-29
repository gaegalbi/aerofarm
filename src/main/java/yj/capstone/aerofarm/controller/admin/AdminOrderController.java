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
import yj.capstone.aerofarm.dto.response.AdminOrderListResponseDto;
import yj.capstone.aerofarm.service.OrderService;


@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('ADMIN')")
public class AdminOrderController {

    private final OrderService orderService;

    @GetMapping("/admin/order-list")
    public String orderList(@PageableDefault Pageable pageable, Model model) {
        Page<AdminOrderListResponseDto> orderList = orderService.findAdminOrderListDto(pageable);
        PageableList<AdminOrderListResponseDto> pageableList = new PageableList<>(orderList);
        model.addAttribute("pageableList", pageableList);
        return "admin/orderListPage";
    }
}
