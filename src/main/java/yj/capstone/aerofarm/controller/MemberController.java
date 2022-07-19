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
import yj.capstone.aerofarm.dto.request.DeviceRegisterRequestDto;
import yj.capstone.aerofarm.dto.request.ProfileEditRequest;
import yj.capstone.aerofarm.dto.response.CommentListResponseDto;
import yj.capstone.aerofarm.dto.response.DeviceMemberListResponseDto;
import yj.capstone.aerofarm.dto.response.PostListResponseDto;
import yj.capstone.aerofarm.exception.DuplicateValueException;
import yj.capstone.aerofarm.exception.UuidNotMatchException;
import yj.capstone.aerofarm.form.InitPasswordForm;
import yj.capstone.aerofarm.service.DeviceService;
import yj.capstone.aerofarm.service.MemberService;
import yj.capstone.aerofarm.service.OrderService;
import yj.capstone.aerofarm.service.PostService;

import javax.validation.Valid;

import java.io.*;

import static yj.capstone.aerofarm.dto.Message.createMessage;

@Controller
@PreAuthorize("hasAnyAuthority('GUEST')")
@RequiredArgsConstructor
@Slf4j
@SessionAttributes("verify")
public class MemberController {

    private final MemberService memberService;
    private final OrderService orderService;
    private final PostService postService;
    private final DeviceService deviceService;

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
        Member member = memberService.findMember(userDetails.getUsername());
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

    @GetMapping("/api/my-page/info")
    @ResponseBody
    public MemberDto memberInfoApi(@AuthenticationPrincipal UserDetailsImpl userDetails) {
        Member member = memberService.findMember(userDetails.getUsername());
        return MemberDto.builder()
                .email(member.getEmail())
                .phoneNumber(member.getPhoneNumber())
                .name(member.getName())
                .picture(member.getPicture())
                .nickname(member.getNickname())
                .addressInfo(member.getAddressInfo())
                .build();
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
        MemberDto memberDto = getMemberDto(userDetails.getMember());
        Page<OrderInfoDto> orderInfo = orderService.findOrderInfoByMemberId(userDetails.getMember().getId(), pageable);
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

    @PostMapping("/my-page/save-img")
    public String saveImg(File file) throws IOException {
        FileOutputStream outputStream = new FileOutputStream("D:/capstone/src/main/resources/static/image/" + file.getName());
        FileInputStream inputStream = new FileInputStream(file);

        int readCount = 0;
        byte[] buffer = new byte[1024];

        while((readCount = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, readCount);
        }

        return file.getName();
    }

    @GetMapping("/my-page/edit")
    public String editPage(Model model, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        Member member = memberService.findMember(userDetails.getUsername());
        MemberDto memberDto = MemberDto.builder()
                .email(member.getEmail())
                .phoneNumber(member.getPhoneNumber())
                .name(member.getName())
                .picture(member.getPicture())
                .nickname(member.getNickname())
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

    @GetMapping("/my-page/posts")
    public String postList(Model model, @AuthenticationPrincipal UserDetailsImpl userDetails, @PageableDefault Pageable pageable) {
        MemberDto memberDto = getMemberDto(userDetails.getMember());
        Page<PostListResponseDto> postList = postService.findMyPostList(userDetails.getMember().getId(), pageable);
        PageableList<PostListResponseDto> pageableList = new PageableList<>(postList);

        model.addAttribute("memberDto", memberDto);
        model.addAttribute("pageableList", pageableList);
        return "member/memberInfoPostPage";
    }

    @GetMapping("/my-page/comments")
    public String commentList(Model model, @AuthenticationPrincipal UserDetailsImpl userDetails, @PageableDefault Pageable pageable) {
        MemberDto memberDto = getMemberDto(userDetails.getMember());
        Page<CommentListResponseDto> commentList = postService.findMyCommentList(userDetails.getMember().getId(), pageable);
        PageableList<CommentListResponseDto> pageableList = new PageableList<>(commentList);

        model.addAttribute("memberDto", memberDto);
        model.addAttribute("pageableList", pageableList);
        return "member/memberInfoCommentPage";
    }

    @GetMapping("/my-page/devices")
    public String deviceList(Model model, @AuthenticationPrincipal UserDetailsImpl userDetails, @PageableDefault Pageable pageable) {
        Member member = userDetails.getMember();
        Page<DeviceMemberListResponseDto> devices = deviceService.findMemberDeviceList(member.getId(), pageable);
        PageableList<DeviceMemberListResponseDto> pageableList = new PageableList<>(devices);
        MemberDto memberDto = getMemberDto(member);
        model.addAttribute("memberDto", memberDto);
        model.addAttribute("pageableList", pageableList);
        return "member/memberDeviceListPage";
    }

    @GetMapping("/my-page/devices/register")
    public String deviceRegisterPage() {
        return "member/memberDeviceRegisterPage";
    }

    @PostMapping("/my-page/devices/register")
    @ResponseBody
    public ResponseEntity<Message> registerDevice(@RequestBody DeviceRegisterRequestDto deviceRegisterRequestDto, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        deviceService.register(userDetails.getMember(), deviceRegisterRequestDto);
        return ResponseEntity.ok()
                .body(createMessage("기기가 등록됬습니다."));
    }

    private MemberDto getMemberDto(Member member) {
        return MemberDto.builder()
                .picture(member.getPicture())
                .nickname(member.getNickname())
                .build();
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(UuidNotMatchException.class)
    public ErrorResponse uuidNotMatch(UuidNotMatchException e) {
        ErrorResponse response = new ErrorResponse(e.getMessage());
        response.addValidation("uuid","해당되는 기기가 없습니다.");
        return response;
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
