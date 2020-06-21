package com.homes.ds.service;

import java.util.Map;

import com.homes.ds.model.Category;

public interface CategoryService {

	/**
	 * 마지막 코드 정보 조회 Service
	 * 
	 * @param category
	 * @return
	 */
	public Map<String, Object> selectLastCode(Category category);
	
	/**
	 * 카테고리 저장 Service
	 *  -> 등록, 수정, 삭제
	 * 
	 * @param category
	 * @param type
	 * @return
	 */
	public Map<String, Object> change(Category category, String type);
	
	/**
	 * 카테고리 목록 조회 Service
	 * 
	 * @param category
	 * @return
	 */
	public Map<String, Object> select(Category category);
	
	/**
	 * 카테고리 상세 조회 Service
	 * @param category
	 * @return
	 */
	public Map<String, Object> detail(Category category);
}
