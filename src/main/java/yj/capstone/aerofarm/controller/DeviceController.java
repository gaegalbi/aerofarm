package yj.capstone.aerofarm.controller;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import yj.capstone.aerofarm.dto.TestDto;

@Controller
public class DeviceController {

    // TODO WebClient 테스트용!!
    @PostMapping("/device/test")
    @ResponseBody
    public Mono<TestDto> test(@RequestParam String ip) {
        WebClient webClient = WebClient.builder()
                .build();

        WebClient newWeb = webClient.mutate()
                .baseUrl(ip)
                .build();

        return newWeb.get()
                .accept(MediaType.APPLICATION_JSON)
                .retrieve()
                .bodyToMono(TestDto.class);
    }
}
