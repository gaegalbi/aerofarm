package yj.capstone.aerofarm.controller;

import lombok.Getter;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MessageController {

    String authNumber = "";

    /**
     * 단일 메시지 발송 예제
     */
    @GetMapping("/my-page/edit/send-message")
    public String sendOne(@RequestParam(value = "phoneNumber", defaultValue = "01045611227") String phoneNumber) {

        final DefaultMessageService messageService = NurigoApp.INSTANCE.initialize("NCS6BCUVQZ7HCCVH", "GSLQLTZACITS1QSAWGYLMQWQRSCZBHIV", "https://api.coolsms.co.kr");

        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.

        authNumber="";
        for(int i=0;i<6;i++)
            authNumber += (int)(Math.random()*10);

        message.setFrom("01045611227");
        message.setTo(phoneNumber);
        message.setText("[도시농부] 인증번호 [" + authNumber + "]를 입력해주세요.");

        SingleMessageSentResponse response = messageService.sendOne(new SingleMessageSendingRequest(message));

        return "redirect:/my-page/edit";
    }

    @GetMapping("/my-page/edit/get-auth")
    public String getAuthNumber() {
        return this.authNumber;
    }
}
