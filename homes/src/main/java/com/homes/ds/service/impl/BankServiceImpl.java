package com.homes.ds.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homes.ds.mapper.BankMapper;
import com.homes.ds.service.BankService;
import com.homes.ds.util.ResponseUtil;

@Service
public class BankServiceImpl implements BankService {
	
	@Autowired
	private BankMapper bankMapper;
	
	/**
	 * 은행 목록 조회
	 */
	@Override
	public Map<String, Object> list() {
		
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", bankMapper.list());
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}

}
