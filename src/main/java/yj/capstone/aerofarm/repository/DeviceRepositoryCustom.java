package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.dto.response.DeviceAdminListResponseDto;
import yj.capstone.aerofarm.dto.response.DeviceMemberListResponseDto;

public interface DeviceRepositoryCustom {

    Page<DeviceAdminListResponseDto> findAdminDeviceList(Pageable pageable);

    Page<DeviceMemberListResponseDto> findMemberDeviceList(Long memberId, Pageable pageable);
}
