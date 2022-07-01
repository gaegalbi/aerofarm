package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.dto.response.DeviceAdminListResponseDto;

public interface DeviceRepositoryCustom {

    Page<DeviceAdminListResponseDto> findAdminList(Pageable pageable);

}