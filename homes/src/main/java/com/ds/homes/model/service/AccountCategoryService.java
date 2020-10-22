package com.ds.homes.model.service;

import java.util.Map;

import com.ds.homes.model.AccountCategory;

/**
 * AccountCategory Service
 * 
 * @author idaesan
 *
 */
public interface AccountCategoryService {

	/**
	 * 목록 조회 Service
	 * 
	 * @param accountCategory
	 * @return
	 */
	public Map<String, Object> list(AccountCategory accountCategory);
	
	/**
	 * 가계부에서 조회할 목록 Service
	 * 
	 * @param accountCategory
	 * @return
	 */
	public Map<String, Object> listOfAccountBook(AccountCategory accountCategory);
	
	/**
	 * 등록 Service
	 * 
	 * @param accountCategory
	 * @return
	 */
	public Map<String, Object> merge(AccountCategory accountCategory, String type);
}
