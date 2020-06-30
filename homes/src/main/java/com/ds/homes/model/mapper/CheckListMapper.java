package com.ds.homes.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.CheckList;

/**
 * 체크리스트 Mapper
 * 
 * @author idaesan
 *
 */
@Mapper
public interface CheckListMapper {

	/**
	 * 체크리스트 등록 Mapper
	 * 
	 * @param checkList
	 * @return
	 */
	public Integer insert(CheckList checkList);
	
	/**
	 * 체크리스트 수정 Mapper
	 * 
	 * @param checkList
	 * @return
	 */
	public Integer update(CheckList checkList);
	
	/**
	 * 체크리스트 삭제 Mapper
	 * 
	 * @param checkListIdx
	 * @return
	 */
	public Integer delete(Integer checkListIdx);
}
