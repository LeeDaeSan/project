package com.homes.ds.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homes.ds.mapper.BankBookTypeMapper;
import com.homes.ds.service.BankBookTypeService;
import com.homes.ds.util.ResponseUtil;

@Service
public class BankBookTypeServiceImpl implements BankBookTypeService {
	
	@Autowired
	private BankBookTypeMapper bankBookTypeMapper;

	/**
	 * 통장 유형 목록 조회
	 */
	@Override
	public Map<String, Object> select() {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", bankBookTypeMapper.select());
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
}
