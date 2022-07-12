package yj.capstone.aerofarm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import yj.capstone.aerofarm.config.auth.dto.UserDetailsImpl;
import yj.capstone.aerofarm.dto.DeviceIpUuidDto;
import yj.capstone.aerofarm.dto.ErrorResponse;
import yj.capstone.aerofarm.dto.Message;
import yj.capstone.aerofarm.dto.request.DeviceConnInfoRequestDto;
import yj.capstone.aerofarm.dto.request.DeviceSettingDto;
import yj.capstone.aerofarm.dto.request.DeviceSettingUuidDto;
import yj.capstone.aerofarm.dto.response.DeviceMemberListResponseDto;
import yj.capstone.aerofarm.dto.response.DeviceStatusResponseDto;
import yj.capstone.aerofarm.exception.AerofarmTimeoutException;
import yj.capstone.aerofarm.exception.IpNotConfigureException;
import yj.capstone.aerofarm.exception.UuidNotMatchException;
import yj.capstone.aerofarm.service.DeviceService;

@Slf4j
@Controller
@RequiredArgsConstructor
public class DeviceController {
    private final WebClient aerofarmWebClient;
    private final DeviceService deviceService;

    // 쿼리에 UUID 노출되기 때문에 기기 number 값으로 조회
    @GetMapping("/my-page/devices/management/{number}")
    public String deviceDetail(@AuthenticationPrincipal UserDetailsImpl userDetails, @PathVariable Long number, Model model) {
        if (!deviceService.isExistDevice(userDetails.getMember(), number)) {
            return "redirect:/my-page/devices";
        }
        DeviceMemberListResponseDto deviceInfo = deviceService.findDeviceInfo(userDetails.getMember().getId(), number);
        model.addAttribute("deviceInfo", deviceInfo);
        return "device/deviceDetailPage";
    }

    @GetMapping("/api/devices/setting")
    @ResponseBody
    public DeviceSettingDto getSettingValue(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestParam Long number) {
        return deviceService.getDeviceStatus(userDetails.getMember().getId(), number);
    }

    @PostMapping("/api/devices/update")
    @ResponseBody
    public void deviceConnUpdate(@RequestBody DeviceConnInfoRequestDto request) {
        deviceService.updateDeviceIp(request);
    }

    @PostMapping("/my-page/devices/management")
    @ResponseBody
    public ResponseEntity<Message> applyDeviceSetting(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestBody DeviceSettingDto request) {
        log.info("Request update device setting. by {}, device number: {}", userDetails.getUsername(), request.getNumber());
        // request의 number와 user가 소유한 기기의 number가 맞는지 검사하여 응답 처리
        DeviceIpUuidDto deviceIpUuid = deviceService.getDeviceIpUuid(request.getNumber(), userDetails.getMember().getId());

        // uri의 host 주소는 조회한 기기의 ip 값을 사용
        aerofarmWebClient.post()
                .uri(uriBuilder -> uriBuilder
                        .scheme("http")
                        .host(deviceIpUuid.getIp())
                        .port(5111)
                        .path("/test") // TODO 경로 수정할 것
                        .build())
                .bodyValue(new DeviceSettingUuidDto(deviceIpUuid.getUuid(), request))
                .accept(MediaType.APPLICATION_JSON)
                .retrieve()
                .bodyToMono(Void.class)
//                .publishOn(Schedulers.boundedElastic())
                .onErrorMap(error -> {
                    throw new AerofarmTimeoutException("수경재배기 응답 없음");
                })
//                .doOnSuccess(unused -> deviceService.updateDeviceSetting(request))
                .block();
//                .subscribe(); // Async-Non block

        deviceService.updateDeviceSetting(userDetails.getMember().getId() ,request);
        log.info("Device status updated. by {}, device number: {}", userDetails.getUsername(), request.getNumber());
        return ResponseEntity.ok()
                .body(Message.createMessage("설정 값이 적용됬습니다."));
    }

    @PostMapping("/my-page/devices/request-info")
    @ResponseBody
    public Mono<DeviceStatusResponseDto> getDeviceInfo(@AuthenticationPrincipal UserDetailsImpl userDetails, @RequestParam Long number) {

        DeviceIpUuidDto deviceIpUuid = deviceService.getDeviceIpUuid(number, userDetails.getMember().getId());

        return aerofarmWebClient.post()
                .uri(uriBuilder -> uriBuilder
                        .scheme("http")
                        .host(deviceIpUuid.getIp())
                        .port(5111)
                        .path("/test2") // TODO 경로 수정할 것
                        .build())
                .body(BodyInserters.fromFormData("uuid", deviceIpUuid.getUuid()))
                .accept(MediaType.APPLICATION_JSON)
                .retrieve()
                .bodyToMono(DeviceStatusResponseDto.class)
                .onErrorMap(error -> {
                    throw new AerofarmTimeoutException("수경재배기 응답 없음");
                });
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(AerofarmTimeoutException.class)
    public ErrorResponse usernameNotFound(AerofarmTimeoutException e) {
        return new ErrorResponse(e.getMessage());
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(IpNotConfigureException.class)
    public ErrorResponse ipNotConfigure(IpNotConfigureException e) {
        return new ErrorResponse(e.getMessage());
    }

    @ResponseBody
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(UuidNotMatchException.class)
    public ErrorResponse uuidNotMatch(UuidNotMatchException e) {
        return new ErrorResponse(e.getMessage());
    }
}
