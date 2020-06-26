package com.ds.estate.model.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.estate.model.mapper.LineKindsMapper;
import com.ds.estate.model.service.LineKindsService;
import com.ds.estate.tool.util.ResponseUtil;

@Service
public class LineKindsServiceImpl implements LineKindsService {
	
	@Autowired
	private LineKindsMapper lineKindsMapper;
	
	@Override
	public Map<String, Object> list() {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", lineKindsMapper.list());
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}

}
