package com.ds.homes.model.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.mapper.BankMapper;
import com.ds.homes.model.service.BankService;
import com.ds.homes.tools.util.ResponseUtil;

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
