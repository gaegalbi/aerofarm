package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.device.Device;
import yj.capstone.aerofarm.domain.member.Member;

import java.util.Optional;

public interface DeviceRepository extends JpaRepository<Device, Long>, DeviceRepositoryCustom {

    Optional<Device> findByUuidAndOwnerIsNull(String uuid);

    Optional<Device> findByUuidAndOwnerIsNotNull(String uuid);

    boolean existsByOwnerAndNumber(Member member, Long number);
}
