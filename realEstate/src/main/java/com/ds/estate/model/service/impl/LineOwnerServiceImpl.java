package com.ds.estate.model.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.estate.model.LineOwner;
import com.ds.estate.model.mapper.LineOwnerMapper;
import com.ds.estate.model.service.LineOwnerService;
import com.ds.estate.tool.constant.Constant;
import com.ds.estate.tool.util.ResponseUtil;

@Service
public class LineOwnerServiceImpl implements LineOwnerService {
	
	@Autowired
	private LineOwnerMapper lineOwnerMapper;
	
	
	@Override
	public Map<String, Object> list() {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", lineOwnerMapper.list());
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}

	@Override
	public Map<String, Object> merge(LineOwner lineOwner, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			Integer result = 0;
			
			// 등록
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				result = lineOwnerMapper.insert(lineOwner);
			}
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("result", result);
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
}
