package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import yj.capstone.aerofarm.domain.device.Device;
import yj.capstone.aerofarm.domain.device.DeviceStatus;
import yj.capstone.aerofarm.domain.device.Model;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.DeviceIpUuidDto;
import yj.capstone.aerofarm.dto.request.CreateDeviceRequestDto;
import yj.capstone.aerofarm.dto.request.DeviceConnInfoRequestDto;
import yj.capstone.aerofarm.dto.request.DeviceRegisterRequestDto;
import yj.capstone.aerofarm.dto.request.DeviceSettingDto;
import yj.capstone.aerofarm.dto.response.DeviceAdminListResponseDto;
import yj.capstone.aerofarm.dto.response.DeviceMemberListResponseDto;
import yj.capstone.aerofarm.exception.IpNotConfigureException;
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
        Long number = findLastNumberDevice(member);
        device.setOwner(member, number);
        device.changeNickname(deviceRegisterRequestDto.getNickname());
        log.info("Owner of deivce {} is set to {}", device.getUuid(), member.getEmail());
    }

    @Transactional(readOnly = true)
    public Long findLastNumberDevice(Member member) {
        //  처음 등록하는 기기이면 기기 번호 1, 그 외는 가장 높은 번호 + 1
        return 1 + deviceRepository.findLastDeviceNumber(member.getId()).orElse(0L);
    }

    @Transactional(readOnly = true)
    public Page<DeviceMemberListResponseDto> findMemberDeviceList(Long memberId, Pageable pageable) {
        return deviceRepository.findMemberDeviceList(memberId, pageable);
    }

    @Transactional
    public void updateDeviceIp(DeviceConnInfoRequestDto request) {
        Device device = deviceRepository.findByUuidAndOwnerIsNotNull(request.getUuid()).orElseThrow(
                () -> new UsernameNotFoundException("해당 기기의 주인이 없습니다."));

        device.changeIp(request.getIpAddress());
    }

    @Transactional(readOnly = true)
    public DeviceIpUuidDto getDeviceIpUuid(Long number, Long memberId) {
        DeviceIpUuidDto deviceIpUuidDto = deviceRepository.findDeviceIpUuid(number, memberId).orElseThrow(
                () -> new UuidNotMatchException("해당 기기가 없습니다."));

        if (!StringUtils.hasText(deviceIpUuidDto.getIp())) {
            throw new IpNotConfigureException("기기의 아이피가 등록되지 않았습니다.");
        }
        return deviceIpUuidDto;
    }

    @Transactional
    public void updateDeviceSetting(Long memberId, DeviceSettingDto request) {
        DeviceStatus deviceStatus = deviceRepository.findDeviceStatus(memberId, request.getNumber());
        deviceStatus.update(request);
    }

    @Transactional(readOnly = true)
    public DeviceSettingDto getDeviceStatus(Long memberId, Long number) {
        return deviceRepository.findDeviceSettingDto(memberId, number);
    }

    @Transactional(readOnly = true)
    public boolean isExistDevice(Member member, Long number) {
        return deviceRepository.existsByOwnerAndNumber(member, number);
    }

    @Transactional(readOnly = true)
    public DeviceMemberListResponseDto findDeviceInfo(Long memberId, Long number) {
        return deviceRepository.findDeviceInfo(memberId, number);
    }
}
