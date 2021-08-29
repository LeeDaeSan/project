package com.ds.home.realestate.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.home.etc.util.ResponseUtil;
import com.ds.home.etc.util.StringUtil;
import com.ds.home.realestate.mapper.StationInfoMapper;
import com.ds.home.realestate.service.StationInfoService;

@Service
public class StationInfoServiceImpl implements StationInfoService {

	@Autowired
	private StationInfoMapper stationInfoMapper;
	
	@Override
	public Map<String, Object> list() {
		
		Map<String, Object> resultMap = null;
		
		try {
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", stationInfoMapper.list());
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> detail(String stationLineNo) {
		
		Map<String, Object> resultMap = null;
		
		try {
			
			if (StringUtil.isNotEmpty(stationLineNo)) {
				resultMap = ResponseUtil.successMap();
				resultMap.put("detail", stationInfoMapper.detail(stationLineNo));
			}
			
		} catch (Exception e) {
			
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
			
		}
		
		return resultMap;
	}
	
}
