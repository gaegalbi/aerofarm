package yj.capstone.aerofarm.domain.device;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import yj.capstone.aerofarm.domain.BaseEntity;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.plant.Plant;
import yj.capstone.aerofarm.exception.UuidNotMatchException;

import javax.persistence.*;

@Getter
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Device extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nickname;

    private String imageUrl;

    // 기기의 고유 MAC 주소
    private String macAddress;

    private String ipAddress;

    // CDKEY 개념, 변경 가능
    private String uuid;

    @OneToOne(mappedBy = "device", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private DeviceStatus deviceStatus;

    @Enumerated(EnumType.STRING)
    private Model model;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "plant_id")
    private Plant plant;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member owner;

    private void setDeviceStatus(DeviceStatus status) {
        this.deviceStatus = status;
    }

    private Device(String uuid, Model model) {
        this.deviceStatus = new DeviceStatus(this);
        this.uuid = uuid;
        this.model = model;
        this.imageUrl = "https://via.placeholder.com/150x150";
    }

    // 관리자용
    public static Device create(String uuid, Model model) {
        Device device = new Device(uuid, model);
        device.setDeviceStatus(new DeviceStatus(device));
        return device;
    }

    public boolean validUuid(String uuid) {
        return this.uuid.equals(uuid);
    }

    public void changeIp(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public void setMacAddress(String uuid, String macAddress) {
        if (validUuid(uuid)) {
            this.macAddress = macAddress;
        }
        throw new UuidNotMatchException("기기의 UUID가 맞지 않습니다.");
    }

    public void setOwner(Member member) {
        this.owner = member;
    }

    public void changeImage(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void changePlant(Plant plant) {
        this.plant = plant;
    }

    public void changeNickname(String nickname) {
        this.nickname = nickname;
    }
}
