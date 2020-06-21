package com.homes.ds.service;

import java.util.Map;

import com.homes.ds.model.CheckList;
import com.homes.ds.model.CheckMemo;

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
	public Map<String, Object> merge(CheckMemo checkMemo, String type);
	
	/**
	 * 체크리스트 check / uncheck update Service
	 * 
	 * @param checkList
	 * @return
	 */
	public Map<String, Object> checked(CheckList checkList);
	
	/**
	 * 체크리스트 수정, 삭제 Service
	 * 
	 * @param checkList
	 * @return
	 */
	public Map<String, Object> merge(CheckList checkList, String type);
}
