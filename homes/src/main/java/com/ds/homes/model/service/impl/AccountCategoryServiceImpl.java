package com.ds.homes.model.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.AccountCategory;
import com.ds.homes.model.mapper.AccountCategoryMapper;
import com.ds.homes.model.service.AccountCategoryService;
import com.ds.homes.tools.constant.Constant;
import com.ds.homes.tools.util.ResponseUtil;

@Service
public class AccountCategoryServiceImpl implements AccountCategoryService {
	
	@Autowired
	private AccountCategoryMapper accountCategoryMapper;
	
	/**
	 * 목록 조회
	 */
	@Override
	public Map<String, Object> list(AccountCategory accountCategory) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			resultMap.put("list", accountCategoryMapper.list(accountCategory));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}

	@Override
	public Map<String, Object> listOfAccountBook(AccountCategory accountCategory) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", accountCategoryMapper.listOfAccountBook(accountCategory));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> merge(AccountCategory accountCategory, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			Integer result = 0;
			
			// 등록
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				result = accountCategoryMapper.insert(accountCategory);
			}
			
			resultMap.put("result", result);
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
}
