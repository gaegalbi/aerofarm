package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.member.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {

    boolean existsByEmailAndPassword(String email, String password);

    boolean existsByEmail(String email);

    boolean existsByNickname(String nickname);

    boolean existsByPhoneNumber(String phoneNumber);
}
