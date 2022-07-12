package yj.capstone.aerofarm.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import yj.capstone.aerofarm.domain.device.Device;
import yj.capstone.aerofarm.domain.device.Model;

import javax.persistence.EntityManager;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
class DeviceRepositoryTest {

    @Autowired
    DeviceRepository deviceRepository;

    @Autowired
    EntityManager em;

    @Test
    void create_device() {
        // given
        Device device = Device.create(UUID.randomUUID().toString(), Model.DS_001);
        deviceRepository.save(device);
        em.flush();
        em.clear();

        // when
        Device findDevice = deviceRepository.findById(device.getId()).get();

        // then
        assertThat(findDevice.getId()).isNotNull();
        assertThat(findDevice.getUuid()).isNotNull();
        assertThat(findDevice.getDeviceStatus()).isNotNull();
    }
}