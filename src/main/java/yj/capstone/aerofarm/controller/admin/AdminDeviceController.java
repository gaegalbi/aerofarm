package yj.capstone.aerofarm.controller.admin;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import yj.capstone.aerofarm.service.DeviceService;

@Controller
@RequiredArgsConstructor
public class AdminDeviceController {

    private final DeviceService deviceService;

    @GetMapping("/admin/devices/create")
    public String createDeviceForm() {
        return "admin/deviceCreatePage";
    }
}
