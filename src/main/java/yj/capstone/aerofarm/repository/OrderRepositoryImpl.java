package yj.capstone.aerofarm.repository;

import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.JPAExpressions;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.order.Order;
import yj.capstone.aerofarm.domain.order.OrderLine;
import yj.capstone.aerofarm.domain.order.QOrder;
import yj.capstone.aerofarm.domain.order.QOrderLine;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.domain.product.QProduct;
import yj.capstone.aerofarm.dto.OrderInfoDto;
import yj.capstone.aerofarm.dto.QOrderInfoDto;
import yj.capstone.aerofarm.repository.support.Querydsl5RepositorySupport;

import static yj.capstone.aerofarm.domain.order.QOrder.*;
import static yj.capstone.aerofarm.domain.order.QOrderLine.*;
import static yj.capstone.aerofarm.domain.product.QProduct.*;

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

    private BooleanExpression memberIdEq(Long memberId) {
        return memberId == null ? null : order.orderer.id.eq(memberId);
    }
}
