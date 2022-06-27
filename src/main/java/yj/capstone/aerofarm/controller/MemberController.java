package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.dto.*;
import yj.capstone.aerofarm.dto.request.ProfileEditRequest;
import yj.capstone.aerofarm.exception.DuplicateValueException;
import yj.capstone.aerofarm.form.InitPasswordForm;
import yj.capstone.aerofarm.service.MemberService;
import yj.capstone.aerofarm.service.OrderService;

import javax.validation.Valid;

import static yj.capstone.aerofarm.dto.Message.createMessage;

@Controller
@PreAuthorize("hasAnyAuthority('GUEST')")
@RequiredArgsConstructor
@Slf4j
@SessionAttributes("verify")
public class MemberController {

    private final MemberService memberService;
    private final OrderService orderService;

    // TODO AOP 사용해서 인증 여부 관련 공통화 필요
    @ModelAttribute("verify")
    public MyPageAuthDto setMyPageSession() {
        return new MyPageAuthDto();
    }

    @GetMapping("/my-page/need-auth")
    public String loginCheckForm(@ModelAttribute("verify") MyPageAuthDto verify, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        if (!StringUtils.hasText(userDetails.getPassword())) {
            return "redirect:/my-page/init-password";
        }
        return "member/needAuthPage";
    }

    @PostMapping("/my-page/need-auth")
    public String loginAuth(@ModelAttribute("verify") MyPageAuthDto verify, String password, @AuthenticationPrincipal UserDetailsImpl userDetails, Model model) {
        boolean result = memberService.verifyPassword(password, userDetails.getPassword());
        if (result) {
            verify.setVerify(true);
            return "redirect:/my-page/info";
        }
        model.addAttribute("error", true);
        return "member/needAuthPage";
    }

    @GetMapping("/my-page/init-password")
    public String initPasswordForm(Model model) {
        model.addAttribute("initPasswordForm", new InitPasswordForm());
        return "member/initPasswordPage";
    }

    @PostMapping("/my-page/init-password")
    public String initPassword(@AuthenticationPrincipal UserDetailsImpl userDetails, @Valid InitPasswordForm initPasswordForm, BindingResult bindingResult) {
        if (!initPasswordForm.isPasswordMatch()) {
            bindingResult.rejectValue("password", "notMatch");
        }
        if (bindingResult.hasErrors()) {
            return "member/initPasswordPage";
        }

        Member member = memberService.changePassword(userDetails.getUsername(), initPasswordForm.getPassword());
        userDetails.updateMember(member);
        return "redirect:/my-page/info";
    }

    @GetMapping("/my-page/info")
    public String memberInfo(@ModelAttribute("verify") MyPageAuthDto verify, Model model, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        if (!verify.isVerify()) {
            return "redirect:/my-page/need-auth";
        }

        Member member = userDetails.getMember();
        MemberDto memberDto = MemberDto.builder()
                .email(member.getEmail())
                .phoneNumber(member.getPhoneNumber())
                .name(member.getName())
                .picture(member.getPicture())
                .nickname(member.getNickname())
                .addressInfo(member.getAddressInfo())
                .build();

        model.addAttribute("memberDto", memberDto);
        return "member/memberInfo";
    }

    @GetMapping("/my-page/order-list")
    public String memberInfoOrderList(
            @ModelAttribute("verify") MyPageAuthDto verify,
            Model model,
            @AuthenticationPrincipal UserDetailsImpl userDetails,
            @PageableDefault Pageable pageable) {
        if (!verify.isVerify()) {
            return "redirect:/my-page/need-auth";
        }
        Member member = userDetails.getMember();
        MemberDto memberDto = MemberDto.builder()
                .picture(member.getPicture())
                .nickname(member.getNickname())
                .build();

        Page<OrderInfoDto> orderInfo = orderService.findOrderInfoByMemberId(member.getId(), pageable);
        PageableList<OrderInfoDto> pageableList = new PageableList<>(orderInfo);

        model.addAttribute("pageableList", pageableList);
        model.addAttribute("memberDto", memberDto);
        return "member/memberInfoOrderList";
    }

    @GetMapping("/my-page/order-list/{uuid}")
    public String memberInfoOrderDetail(@ModelAttribute("verify") MyPageAuthDto verify, Model model, @PathVariable String uuid) {
        if (!verify.isVerify()) {
            return "redirect:/my-page/need-auth";
        }
        try {
            Order order = orderService.findByUuid(uuid);
            CheckoutCompleteDto checkoutCompleteDto = orderService.createOrderDetail(order);

            model.addAttribute("orderUuid", uuid);
            model.addAttribute("reviewd", order.isReviewed());
            model.addAttribute("checkoutCompleteDto", checkoutCompleteDto);
            model.addAttribute("totalPrice", order.getTotalPrice().getMoney());
            model.addAttribute("deliveryPrice", 2500);

        } catch (IllegalArgumentException e) {
            return "redirect:/";
        }
        return "member/orderDetailPage";
    }

    @GetMapping("/my-page/edit")
    public String editPage(Model model, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        Member member = userDetails.getMember();
        MemberDto memberDto = MemberDto.builder()
                .name(member.getName())
                .nickname(member.getNickname())
                .phoneNumber(member.getPhoneNumber())
                .addressInfo(member.getAddressInfo())
                .build();

        model.addAttribute("memberDto", memberDto);

        return "member/memberEdit";
    }

    @PostMapping("/my-page/edit")
    @ResponseBody
    public ResponseEntity<Message> editProfile(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody @Valid ProfileEditRequest profileEditRequest) {
        Member member = memberService.editProfile(userDetails.getUsername(), profileEditRequest);
        userDetails.updateMember(member);
        return ResponseEntity.ok()
                .body(createMessage("정보가 수정 되었습니다."));
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(DuplicateValueException.class)
    public ErrorResponse duplicateNickname(DuplicateValueException e) {
        ErrorResponse response = new ErrorResponse(e.getMessage());
        response.addValidation("nickname","해당 닉네임이 이미 있습니다.");
        return response;
    }
}
