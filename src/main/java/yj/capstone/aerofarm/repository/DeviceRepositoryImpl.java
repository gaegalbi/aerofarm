package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.device.Device;
import yj.capstone.aerofarm.dto.response.DeviceAdminListResponseDto;
import yj.capstone.aerofarm.dto.response.DeviceMemberListResponseDto;
import yj.capstone.aerofarm.dto.response.QDeviceAdminListResponseDto;
import yj.capstone.aerofarm.dto.response.QDeviceMemberListResponseDto;
import yj.capstone.aerofarm.repository.support.Querydsl5RepositorySupport;

import static yj.capstone.aerofarm.domain.device.QDevice.device;
import static yj.capstone.aerofarm.domain.member.QMember.member;
import static yj.capstone.aerofarm.domain.plant.QPlant.plant;

public class DeviceRepositoryImpl extends Querydsl5RepositorySupport implements DeviceRepositoryCustom {

    public DeviceRepositoryImpl() {
        super(Device.class);
    }

    @Override
    public Page<DeviceAdminListResponseDto> findAdminDeviceList(Pageable pageable) {
        return applyPagination(pageable,
                query -> query
                        .select(new QDeviceAdminListResponseDto(
                                device.id,
                                device.ipAddress,
                                device.macAddress,
                                device.model,
                                device.uuid,
                                device.owner.email.as("owner"),
                                device.ipAddress
                        ))
                        .from(device)
                        .leftJoin(device.owner, member)
                        .leftJoin(device.plant, plant),

                        query -> query
                        .select(device.count())
                        .from(device)
        );
    }

    @Override
    public Page<DeviceMemberListResponseDto> findMemberDeviceList(Long memberId, Pageable pageable) {
        return applyPagination(pageable,
                query -> query
                        .select(new QDeviceMemberListResponseDto(
                                device.uuid,
                                device.nickname,
                                device.imageUrl,
                                device.model,
                                plant.name.as("plant")
                        ))
                        .from(device)
                        .leftJoin(device.plant, plant)
                        .where(device.owner.id.eq(memberId)),

                query -> query
                        .select(device.count())
                        .from(device)
                        .where(device.owner.id.eq(memberId))
        );
    }
}
