package yj.capstone.aerofarm.controller.admin;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import yj.capstone.aerofarm.dto.Message;
import yj.capstone.aerofarm.dto.request.CreateDeviceRequestDto;
import yj.capstone.aerofarm.dto.response.DeviceAdminListResponseDto;
import yj.capstone.aerofarm.service.DeviceService;

import javax.validation.Valid;

import static yj.capstone.aerofarm.dto.Message.createMessage;

@Controller
@RequiredArgsConstructor
public class AdminDeviceController {

    private final DeviceService deviceService;

    @GetMapping("/admin/devices/create")
    public String createDeviceForm() {
        return "admin/deviceCreatePage";
    }

    @PostMapping("/admin/devices/create")
    @ResponseBody
    public ResponseEntity<Message> createDevice(@RequestBody @Valid CreateDeviceRequestDto createDeviceRequestDto) {
        deviceService.createDevices(createDeviceRequestDto);
        return ResponseEntity.ok()
                .body(createMessage("기기가 등록 되었습니다."));
    }

    @GetMapping("/admin/devices")
    @ResponseBody
    public Page<DeviceAdminListResponseDto> findDevices(@PageableDefault Pageable pageable) {
        return deviceService.findAdminDeviceList(pageable);
    }
}
