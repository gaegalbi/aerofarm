package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.device.Device;
import yj.capstone.aerofarm.domain.device.Model;
import yj.capstone.aerofarm.dto.request.CreateDeviceRequestDto;
import yj.capstone.aerofarm.dto.response.DeviceAdminListResponseDto;
import yj.capstone.aerofarm.repository.DeviceRepository;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class DeviceService {

    private final DeviceRepository deviceRepository;

    @Transactional
    public void createDevices(CreateDeviceRequestDto createDeviceRequestDto) {
        Model model = Model.findModel(createDeviceRequestDto.getModel());
        for (int i = 0; i < createDeviceRequestDto.getQuantity(); i++) {
            String uuid = UUID.randomUUID().toString();
            Device device = Device.create(uuid, model);
            deviceRepository.save(device);
            log.info("Device created. UUID = {}", uuid);
        }
    }

    public Page<DeviceAdminListResponseDto> findAdminDeviceList(Pageable pageable) {
        return deviceRepository.findAdminList(pageable);
    }
}
