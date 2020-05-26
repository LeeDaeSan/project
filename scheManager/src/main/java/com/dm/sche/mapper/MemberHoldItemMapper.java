package com.dm.sche.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.MemberHoldItem;

@Mapper
public interface MemberHoldItemMapper {

	/**
	 * 사용자 가계 목록
	 * @param memberHoldItem
	 * @return
	 */
	public List<MemberHoldItem> select (PagingDTO<MemberHoldItem> pagingDTO);
	
	/**
	 * 사용자 가계 등록
	 * @param memberHoldItem
	 */
	public Integer insert(MemberHoldItem memberHoldItem);
	
	/**
	 * 사용자 가계 삭제
	 * @param memberHoldItem
	 * @return
	 */
	public Integer delete(MemberHoldItem memberHoldItem);
	
	/**
	 * 사용자 가계 정보 카운트 (가계 PK 기준)
	 * @param idx
	 * @return
	 */
	public Long memberHoldItemOfCount(int idx);
}
