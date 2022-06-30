package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.device.Device;

public interface DeviceRepository extends JpaRepository<Device, Long> {
}
