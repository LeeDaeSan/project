package com.homes.ds.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.homes.ds.model.CheckMemo;

/**
 * 체크 메모 정보 Mapper
 * 
 * @author idaesan
 *
 */
@Mapper
public interface CheckMemoMapper {

	/**
	 * 체크 메모 정보 조회 Mapper
	 * 
	 * @param checkMemo
	 * @return
	 */
	public CheckMemo select(CheckMemo checkMemo);
	
	/**
	 * 체크 메모 정보 등록 Mapper
	 * 
	 * @param checkMemo
	 * @return
	 */
	public Integer insert(CheckMemo checkMemo);
	
	/**
	 * 체크 메모 정보 수정 Mapper
	 * 
	 * @param checkMemo
	 * @return
	 */
	public Integer update(CheckMemo checkMemo);
}
