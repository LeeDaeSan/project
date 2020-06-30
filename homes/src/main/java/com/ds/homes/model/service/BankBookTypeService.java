package com.ds.homes.model.service;

import java.util.Map;

/**
 * 통장 유형 정보 Service
 * 
 * @author idaesan
 *
 */
public interface BankBookTypeService {

	/**
	 * 통장 유형 목록 조회 Service
	 *  
	 * @return
	 */
	public Map<String, Object> select();
}
