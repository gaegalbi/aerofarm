package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.member.PasswordResetToken;

import java.time.LocalDateTime;
import java.util.Optional;

public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, String> {
    Optional<PasswordResetToken> findByIdAndExpirationDateAfter(String id, LocalDateTime now);

    boolean existsByIdAndExpirationDateAfter(String id, LocalDateTime now);

    boolean existsByEmail(String email);

    void deleteByEmail(String email);
}
