package yj.capstone.aerofarm.dto.response;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;
import yj.capstone.aerofarm.domain.order.DeliveryStatus;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
@Setter
public class AdminOrderListResponseDto {
    private Long id;
    private String email; // 주문자
    private DeliveryStatus deliveryStatus;
    private int totalPrice;
    private String uuid;
    private String orderDate;

    @QueryProjection
    public AdminOrderListResponseDto(Long id, String email, DeliveryStatus deliveryStatus, int totalPrice, String uuid, LocalDateTime orderDate) {
        this.id = id;
        this.email = email;
        this.deliveryStatus = deliveryStatus;
        this.totalPrice = totalPrice;
        this.uuid = uuid;
        this.orderDate = orderDate.format(DateTimeFormatter.ISO_LOCAL_DATE);;
    }
}
