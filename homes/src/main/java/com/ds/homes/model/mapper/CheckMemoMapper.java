package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.CheckMemo;

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
	public List<CheckMemo> select(CheckMemo checkMemo);
	
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
	
	/**
	 * 체크 메모 정보 삭제 Mapper
	 * 
	 * @param checkMemoIdx
	 * @return
	 */
	public Integer delete(Integer checkMemoIdx);
}
