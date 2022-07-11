package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.device.DeviceStatus;
import yj.capstone.aerofarm.dto.DeviceIpUuidDto;
import yj.capstone.aerofarm.dto.request.DeviceSettingDto;
import yj.capstone.aerofarm.dto.response.DeviceAdminListResponseDto;
import yj.capstone.aerofarm.dto.response.DeviceMemberListResponseDto;

import java.util.Optional;

public interface DeviceRepositoryCustom {

    Page<DeviceAdminListResponseDto> findAdminDeviceList(Pageable pageable);

    Page<DeviceMemberListResponseDto> findMemberDeviceList(Long memberId, Pageable pageable);

    Optional<DeviceIpUuidDto> findDeviceIpUuid(Long number, Long memberId);

    DeviceStatus findDeviceStatus(Long memberId ,Long number);

    Optional<Long> findLastDeviceNumber(Long memberId);

    DeviceSettingDto findDeviceSettingDto(Long memberId, Long number);

    DeviceMemberListResponseDto findDeviceInfo(Long memberId, Long number);
}
