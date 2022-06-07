package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.dto.ProductStoreInfoDto;


public interface ProductRepositoryCustom {

    Page<ProductStoreInfoDto> findProductInfo(ProductCategory category, String order, Pageable pageable);
}
