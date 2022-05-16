package yj.capstone.aerofarm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import yj.capstone.aerofarm.domain.order.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {
}
