package yj.capstone.aerofarm.domain.member;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Slf4j
public class MessageAuthToken {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String phoneNumber;

    private String authNumber;

    //private LocalDateTime expirationDate;

    public static MessageAuthToken createMessageAuthToken(String phoneNumber) {
        MessageAuthToken token = new MessageAuthToken();

        StringBuilder authNumber = new StringBuilder();

        for(int i=0;i<6;i++)
            authNumber.append((int) (Math.random() * 10));

        //token.expirationDate = LocalDateTime.now().plusMinutes(3);
        token.phoneNumber = phoneNumber;
        token.authNumber = authNumber.toString();
        return token;
    }
}
