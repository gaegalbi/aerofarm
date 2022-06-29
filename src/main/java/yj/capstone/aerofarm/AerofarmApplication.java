package yj.capstone.aerofarm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@EnableAsync
@SpringBootApplication
public class AerofarmApplication {

	public static void main(String[] args) {
		SpringApplication.run(AerofarmApplication.class, args);
	}

}
