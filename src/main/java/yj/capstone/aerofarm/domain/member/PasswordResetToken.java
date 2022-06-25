package yj.capstone.aerofarm.domain.member;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.time.LocalDateTime;

@Entity
@Getter
@Slf4j
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PasswordResetToken {
    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    @Column(length = 36)
    private String id;

    private LocalDateTime expirationDate;
    private String email;

    public static PasswordResetToken createPasswordResetToken(String email) {
        log.info("createEmailToken: {}", email);
        PasswordResetToken token = new PasswordResetToken();
        token.expirationDate = LocalDateTime.now().plusMinutes(5); // 5분 뒤 만료
        token.email = email;
        return token;
    }
}
