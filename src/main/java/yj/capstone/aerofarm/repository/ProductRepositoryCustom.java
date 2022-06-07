package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.dto.ProductInfoDto;


public interface ProductRepositoryCustom {

    Page<ProductInfoDto> findProductInfo(String order, Pageable pageable);
}
