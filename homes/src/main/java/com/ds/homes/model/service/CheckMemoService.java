package com.ds.homes.model.service;

import java.util.Map;

import com.ds.homes.model.CheckMemo;
import com.ds.homes.model.CheckMemo;
import com.ds.homes.model.dto.CheckMemoDTO;

public interface CheckMemoService {

	/**
	 * 체크 메모 정보 조회 Service
	 * 
	 * @param checkMemo
	 * @return
	 */
	public Map<String, Object> select(CheckMemo checkMemo);
	
	/**
	 * 체크 메모 정보 저장 Service
	 *  -> 등록, 수정
	 *  
	 * @param checkMemo
	 * @return
	 */
	public Map<String, Object> merge(CheckMemoDTO checkListDTO, String type);
	
	/**
	 * 체크 메모 checked / unchecked Service
	 * 
	 * @param checkMemo
	 * @return
	 */
	public Map<String, Object> isChecked(CheckMemo checkMemo);
	
	/**
	 * 체크 메모 정보 삭제 Service
	 * 
	 * @param checkMemoIdx
	 * @return
	 */
	public Map<String, Object> delete(Integer checkMemoIdx);
}
