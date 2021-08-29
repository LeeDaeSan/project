package com.ds.home.realestate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.home.model.MemberRealEstate;
import com.ds.home.model.dto.PagingDTO;

/**
 * 사용자 부동산 정보 Mapper
 * 
 * @author daesan
 *
 */
@Mapper
public interface MemberRealEstateMapper {

	/**
	 * 사용자 부동산 정보 목록 조회
	 * 
	 * @param memberRealEstate
	 * @return
	 */
	public List<MemberRealEstate> select(MemberRealEstate memberRealEstate);

	public List<MemberRealEstate> select(PagingDTO<MemberRealEstate> pagingDTO);
	
	/**
	 * 사용자 부동산 정보 total count 조회
	 * 
	 * @param pagingDTO
	 * @return
	 */
	public Long selectOfTotalCount(PagingDTO<MemberRealEstate> pagingDTO);
	
	/**
	 * 사용자 부동산 상세 정보
	 * 
	 * @param idx
	 * @return
	 */
	public MemberRealEstate detail(Integer memberRealEstateIdx, Integer memberIdx);

	/**
	 * 사용자 부동산 정보 등록
	 * 
	 * @param memberRealEstate
	 */
	public void insert(MemberRealEstate memberRealEstate);
	
	/**
	 * 사용자 부동산 정보 수정
	 * 
	 * @param memberRealEstate
	 */
	public void update(MemberRealEstate memberRealEstate);

	/**
	 * 사용자 부동산 정보 삭제
	 * 
	 * @param memberRealEstate
	 */
	public void delete(MemberRealEstate memberRealEstate);
}
