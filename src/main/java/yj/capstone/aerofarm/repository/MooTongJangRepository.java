package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import yj.capstone.aerofarm.domain.order.MooTongJang;

@Repository
public interface MooTongJangRepository extends JpaRepository<MooTongJang, Long> {
}
