package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.dto.OrderInfoDto;

public interface OrderRepositoryCustom {

    Page<OrderInfoDto> findOrderInfoDto(Pageable pageable, Long memberId);
}
