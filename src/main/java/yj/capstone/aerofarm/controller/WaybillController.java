package yj.capstone.aerofarm.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import yj.capstone.aerofarm.dto.request.WaybillRequestDto;

@RestController
public class WaybillController {

    String waybillKey = "p0XRqBRiUyjyBdNATUg2bg";
    @GetMapping("/product/waybill")
    public String waybillEnquire(@RequestBody WaybillRequestDto request) {

        String waybillRequest = "http://info.sweettracker.co.kr/api/v1/trackingInfo?" + "t_key=" + waybillKey
                + "&t_code=" + request.getCompany() + "&t_invoice=" + request.getWaybill();
        return waybillRequest;
    }
}
