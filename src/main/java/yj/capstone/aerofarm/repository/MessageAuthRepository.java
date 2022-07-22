package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import yj.capstone.aerofarm.domain.member.MessageAuthToken;

import java.time.LocalDateTime;
import java.util.Optional;

public interface MessageAuthRepository extends JpaRepository<MessageAuthToken, Long> {

    Optional<MessageAuthToken> findByPhoneNumber(String phoneNumber);

    boolean existsByAuthNumber(String authNumber);

    void deleteByAuthNumber(String authNumber);

    Optional<MessageAuthToken> findByAuthNumber(String authNumber);
}
