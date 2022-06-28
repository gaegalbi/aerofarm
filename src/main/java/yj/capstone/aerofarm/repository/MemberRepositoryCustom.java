package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.dto.response.MemberListResponseDto;
import yj.capstone.aerofarm.dto.response.OrderAddressResponseDto;

public interface MemberRepositoryCustom {
    Page<MemberListResponseDto> findMemberList(Pageable pageable);

    OrderAddressResponseDto findMemberAddress(Long id);
}
