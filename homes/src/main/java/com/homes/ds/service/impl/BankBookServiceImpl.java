package com.homes.ds.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homes.ds.mapper.BankBookMapper;
import com.homes.ds.model.BankBook;
import com.homes.ds.service.BankBookService;
import com.homes.ds.util.ResponseUtil;

@Service
public class BankBookServiceImpl implements BankBookService {
	
	@Autowired
	private BankBookMapper bankBookMapper;
	
	/**
	 * 가계부 목록 조회
	 */
	@Override
	public Map<String, Object> list(BankBook bankBook) {
		
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", bankBookMapper.list(bankBook));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}

}
