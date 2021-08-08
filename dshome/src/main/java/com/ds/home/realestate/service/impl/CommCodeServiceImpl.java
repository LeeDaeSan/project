package com.ds.home.realestate.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.home.etc.util.ResponseUtil;
import com.ds.home.etc.util.StringUtil;
import com.ds.home.realestate.mapper.CommCodeMapper;
import com.ds.home.realestate.service.CommCodeService;

@Service
public class CommCodeServiceImpl implements CommCodeService {
	
	@Autowired
	private CommCodeMapper commCodeMapper;
	
	@Override
	public Map<String, Object> list(String type) {
		
		Map<String, Object> resultMap = null;
		
		try {
			
			if (StringUtil.isNotEmpty(type)) {
				
				resultMap = ResponseUtil.successMap();
				resultMap.put("list", commCodeMapper.list(type));
				
			}
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}

}
