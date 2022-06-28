package yj.capstone.aerofarm.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.Deposit;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.dto.OrderInfoDto;
import yj.capstone.aerofarm.dto.QOrderInfoDto;
import yj.capstone.aerofarm.dto.response.AdminOrderListResponseDto;
import yj.capstone.aerofarm.dto.response.QAdminOrderListResponseDto;
import yj.capstone.aerofarm.repository.support.Querydsl5RepositorySupport;

import static yj.capstone.aerofarm.domain.member.QMember.member;
import static yj.capstone.aerofarm.domain.order.QMooTongJang.mooTongJang;
import static yj.capstone.aerofarm.domain.order.QOrder.order;
import static yj.capstone.aerofarm.domain.order.QOrderLine.orderLine;
import static yj.capstone.aerofarm.domain.product.QProduct.product;

public class OrderRepositoryImpl extends Querydsl5RepositorySupport implements OrderRepositoryCustom {

    public OrderRepositoryImpl() {
        super(Order.class);
    }

    @Override
    public Page<OrderInfoDto> findOrderInfoDto(Pageable pageable, Long memberId) {
        return applyPagination(pageable,
                query -> query
                        .select(new QOrderInfoDto(
                                order.uuid,
                                product.name,
                                order.deliveryStatus,
                                order.totalQuantity,
                                order.totalPrice.money.as("totalPrice"),
                                product.imageUrl.as("thumbnail"),
                                order.createdDate.as("orderDate")))
                        .from(orderLine)
                        .innerJoin(orderLine.order, order)
                        .innerJoin(orderLine.product, product)
                        .where(memberIdEq(memberId),
                                orderLine.delegate.isTrue()),
                query -> query
                        .select(order.count())
                        .from(order)
                        .where(memberIdEq(memberId)));
    }

    @Override
    public Page<AdminOrderListResponseDto> findAdminOrderListDto(Pageable pageable) {
        return applyPagination(pageable,
                query -> query
                        .select(new QAdminOrderListResponseDto(
                                order.id,
                                order.orderer.email,
                                order.deliveryStatus,
                                order.totalPrice.money.as("totalPrice"),
                                order.uuid,
                                order.createdDate.as("orderDate")))
                        .from(order)
                        .innerJoin(order.orderer, member),
                query -> query
                        .select(order.count())
                        .from(order)
        );
    }

    @Override
    public Deposit findDepositByOrderId(Long orderId) {
        return select(mooTongJang.deposit)
                .from(mooTongJang)
                .where(mooTongJang.order.id.eq(orderId))
                .innerJoin(mooTongJang.order, order)
                .fetchOne();
    }

    private BooleanExpression memberIdEq(Long memberId) {
        return memberId == null ? null : order.orderer.id.eq(memberId);
    }
}
