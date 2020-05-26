package com.dm.sche.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dm.sche.model.HouseHoldItemDetail;

@Mapper
public interface HouseHoldItemDetailMapper {

	/**
	 * 대분류 항목 상세 목록 조회
	 * @param pagingDTO
	 * @return
	 */
	public List<HouseHoldItemDetail> select(int itemIdx);
	
	/**
	 * 대분류 항목 상세 정보 카운트 (가계 PK 기준)
	 * @param itemIdx
	 * @return
	 */
	public Long houseHoldItemDetailOfCount (int itemIdx);
}
