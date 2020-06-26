package com.ds.estate.model.service;

import java.util.Map;

import com.ds.estate.model.LineOwner;

/**
 * 라인정보 Service
 * 
 * @author idaesan
 *
 */
public interface LineOwnerService {

	/**
	 * 라인정보 목록 조회
	 * 
	 * @return
	 */
	public Map<String, Object> list();
	
	/**
	 * 라인정보 등록, 수정, 삭제
	 * 
	 * @return
	 */
	public Map<String, Object> merge(LineOwner lineOwner, String type);
}
