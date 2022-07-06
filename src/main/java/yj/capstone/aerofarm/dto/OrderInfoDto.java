package yj.capstone.aerofarm.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import yj.capstone.aerofarm.domain.order.DeliveryStatus;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class OrderInfoDto {

    private String uuid;
    private String name;
    private DeliveryStatus deliveryStatus;
    private long totalQuantity;
    private int totalPrice;
    private String thumbnail;
    private LocalDateTime orderDate;

    @QueryProjection
    public OrderInfoDto(String uuid, String name, DeliveryStatus deliveryStatus, long totalQuantity, int totalPrice, String thumbnail, LocalDateTime orderDate) {
        this.uuid = uuid;
        this.name = name;
        this.deliveryStatus = deliveryStatus;
        this.totalQuantity = totalQuantity;
        this.totalPrice = totalPrice;
        this.thumbnail = thumbnail;
        this.orderDate = orderDate;
    }
}
