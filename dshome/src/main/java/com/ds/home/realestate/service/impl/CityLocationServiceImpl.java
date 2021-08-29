package com.ds.home.realestate.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.home.etc.util.ResponseUtil;
import com.ds.home.etc.util.StringUtil;
import com.ds.home.realestate.mapper.CityLocationMapper;
import com.ds.home.realestate.service.CityLocationService;

@Service
public class CityLocationServiceImpl implements CityLocationService {

	@Autowired
	private CityLocationMapper cityLocationMapper;
	
	@Override
	public Map<String, Object> list(String depth, String cortarNo) {

		Map<String, Object> resultMap = null;
		
		try {
			
			if (StringUtil.isNotEmpty(depth) ) {
				
				resultMap = ResponseUtil.successMap();
				resultMap.put("list", cityLocationMapper.list(depth, cortarNo));
				
			}
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}

	
}
