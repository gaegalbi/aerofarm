package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.product.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
