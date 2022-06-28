package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.dto.response.MemberListResponseDto;
import yj.capstone.aerofarm.dto.response.OrderAddressResponseDto;
import yj.capstone.aerofarm.dto.response.QMemberListResponseDto;
import yj.capstone.aerofarm.dto.response.QOrderAddressResponseDto;
import yj.capstone.aerofarm.repository.support.Querydsl5RepositorySupport;

import static yj.capstone.aerofarm.domain.member.QMember.member;

public class MemberRepositoryImpl extends Querydsl5RepositorySupport implements MemberRepositoryCustom {

    public MemberRepositoryImpl() {
        super(Member.class);
    }

    @Override
    public Page<MemberListResponseDto> findMemberList(Pageable pageable) {
        return applyPagination(pageable,
                query -> query
                        .select(new QMemberListResponseDto(
                                member.id,
                                member.email,
                                member.nickname,
                                member.createdDate))
                        .from(member),

                query -> query
                        .select(member.count())
                        .from(member));
    }

    @Override
    public OrderAddressResponseDto findMemberAddress(Long id) {
        return select(new QOrderAddressResponseDto(
                    member.addressInfo.address1,
                    member.addressInfo.address2,
                    member.addressInfo.extraAddress,
                    member.addressInfo.zipcode,
                    member.name.as("receiver"),
                    member.phoneNumber))
                .from(member)
                .where(member.id.eq(id))
                .fetchOne();
    }
}
