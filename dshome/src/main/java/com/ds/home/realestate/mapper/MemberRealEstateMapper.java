package com.ds.home.realestate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.home.model.MemberRealEstate;

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

	public void insert(String type, MemberRealEstate memberRealEstate, Integer memberIdx);
	
}
