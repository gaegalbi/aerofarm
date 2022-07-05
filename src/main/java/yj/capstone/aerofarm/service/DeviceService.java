package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.device.Device;
import yj.capstone.aerofarm.domain.device.Model;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.request.CreateDeviceRequestDto;
import yj.capstone.aerofarm.dto.request.DeviceRegisterRequestDto;
import yj.capstone.aerofarm.dto.response.DeviceAdminListResponseDto;
import yj.capstone.aerofarm.dto.response.DeviceMemberListResponseDto;
import yj.capstone.aerofarm.exception.UuidNotMatchException;
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

    @Transactional(readOnly = true)
    public Page<DeviceAdminListResponseDto> findAdminDeviceList(Pageable pageable) {
        return deviceRepository.findAdminDeviceList(pageable);
    }

    @Transactional
    public void register(Member member, DeviceRegisterRequestDto deviceRegisterRequestDto) {
        Device device = deviceRepository.findByUuidAndOwnerIsNull(deviceRegisterRequestDto.getUuid()).orElseThrow(() -> new UuidNotMatchException("해당되는 기기가 없습니다."));
        device.setOwner(member);
        device.changeNickname(deviceRegisterRequestDto.getNickname());
        log.info("Owner of deivce {} is set to {}", device.getUuid(), member.getEmail());
    }

    public Page<DeviceMemberListResponseDto> findMemberDeviceList(Long memberId, Pageable pageable) {
        return deviceRepository.findMemberDeviceList(memberId, pageable);
    }

}
