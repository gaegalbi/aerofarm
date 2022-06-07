package yj.capstone.aerofarm.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.dto.ProductStoreInfoDto;
import yj.capstone.aerofarm.dto.QProductStoreInfoDto;

import java.util.List;

import static yj.capstone.aerofarm.domain.product.QProduct.*;
import static yj.capstone.aerofarm.domain.product.QProductReview.*;

@RequiredArgsConstructor
public class ProductRepositoryImpl implements ProductRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<ProductStoreInfoDto> findProductInfo(ProductCategory category, String order, Pageable pageable) {
        List<ProductStoreInfoDto> content = queryFactory
                .select(new QProductStoreInfoDto(
                        product.id.as("productId"),
                        product.imageUrl,
                        product.name,
                        product.price.money.as("price"),
                        productReview.review.count().as("reviewCnt"),
                        productReview.score.avg().as("scoreAvg")))
                .from(productReview)
                .rightJoin(productReview.product, product)
                .groupBy(product.id)
                .where(categoryEq(category))
                .limit(pageable.getPageSize())
                .offset(pageable.getOffset())
                .fetch();

        JPAQuery<Long> countQuery = queryFactory
                .select(product.count())
                .from(product)
                .where(categoryEq(category));

        return PageableExecutionUtils.getPage(content, pageable, countQuery::fetchOne);
    }

    private BooleanExpression categoryEq(ProductCategory category) {
        return category == null ? null : product.category.eq(category);
    }
}
