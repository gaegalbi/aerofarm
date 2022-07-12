package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.device.Device;
import yj.capstone.aerofarm.domain.device.DeviceStatus;
import yj.capstone.aerofarm.dto.DeviceIpUuidDto;
import yj.capstone.aerofarm.dto.QDeviceIpUuidDto;
import yj.capstone.aerofarm.dto.request.DeviceSettingDto;
import yj.capstone.aerofarm.dto.request.QDeviceSettingDto;
import yj.capstone.aerofarm.dto.response.DeviceAdminListResponseDto;
import yj.capstone.aerofarm.dto.response.DeviceMemberListResponseDto;
import yj.capstone.aerofarm.dto.response.QDeviceAdminListResponseDto;
import yj.capstone.aerofarm.dto.response.QDeviceMemberListResponseDto;
import yj.capstone.aerofarm.repository.support.Querydsl5RepositorySupport;

import java.util.Optional;

import static yj.capstone.aerofarm.domain.device.QDevice.device;
import static yj.capstone.aerofarm.domain.device.QDeviceStatus.deviceStatus;
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
                                device.number,
                                device.nickname,
                                device.imageUrl,
                                device.model,
                                plant.name.as("plant"),
                                device.createdDate
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

    @Override
    public Optional<DeviceIpUuidDto> findDeviceIpUuid(Long number, Long memberId) {
        return Optional.ofNullable(
                select(new QDeviceIpUuidDto(
                        device.uuid,
                        device.ipAddress.as("ip")))
                        .from(device)
                        .where(
                                device.number.eq(number),
                                device.owner.id.eq(memberId)
                        )
                        .fetchOne());
    }

    @Override
    public DeviceStatus findDeviceStatus(Long memberId, Long number) {
        return select(device.deviceStatus)
                .from(device)
                .where(
                        device.number.eq(number),
                        device.owner.id.eq(memberId)
                )
                .fetchOne();
    }

    @Override
    public Optional<Long> findLastDeviceNumber(Long memberId) {
        return Optional.ofNullable(select(device.number)
                .from(device)
                .where(device.owner.id.eq(memberId))
                .orderBy(device.number.desc())
                .limit(1)
                .fetchOne());
    }

    @Override
    public DeviceSettingDto findDeviceSettingDto(Long memberId, Long number) {
        return select(new QDeviceSettingDto(
                device.number,
                device.deviceStatus.temperature,
                device.deviceStatus.humidity,
                device.deviceStatus.fertilizer,
                device.deviceStatus.ledOn))
                .from(device)
                .innerJoin(device.deviceStatus, deviceStatus)
                .where(
                        device.owner.id.eq(memberId),
                        device.number.eq(number)
                )
                .fetchOne();
    }

    @Override
    public DeviceMemberListResponseDto findDeviceInfo(Long memberId, Long number) {
        return select(new QDeviceMemberListResponseDto(
                device.number,
                device.nickname,
                device.imageUrl,
                device.model,
                plant.name.as("plant"),
                device.createdDate))
                .from(device)
                .leftJoin(device.plant, plant)
                .where(
                        device.owner.id.eq(memberId),
                        device.number.eq(number)
                )
                .fetchOne();
    }
}
