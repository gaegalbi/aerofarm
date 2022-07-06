package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.Deposit;
import yj.capstone.aerofarm.dto.OrderInfoDto;
import yj.capstone.aerofarm.dto.response.AdminOrderListResponseDto;

public interface OrderRepositoryCustom {

    Page<OrderInfoDto> findOrderInfoDto(Pageable pageable, Long memberId);

    Page<AdminOrderListResponseDto> findAdminOrderListDto(Pageable pageable);

    Deposit findDepositByOrderId(Long orderId);
}
