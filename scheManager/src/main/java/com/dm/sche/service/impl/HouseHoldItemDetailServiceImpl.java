package com.dm.sche.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dm.sche.mapper.HouseHoldItemDetailMapper;
import com.dm.sche.service.HouseHoldItemDetailService;
import com.dm.sche.util.ResponseUtil;

@Service
public class HouseHoldItemDetailServiceImpl implements HouseHoldItemDetailService {

	@Autowired
	private HouseHoldItemDetailMapper houseHoldItemDetailMapper;
	
	/**
	 * 대분류 항목 상세 정보 조회
	 */
	@Override
	public Map<String, Object> select(int itemIdx) {
		
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list"		, houseHoldItemDetailMapper.select(itemIdx));
			resultMap.put("totalcount"	, houseHoldItemDetailMapper.houseHoldItemDetailOfCount(itemIdx));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
}
