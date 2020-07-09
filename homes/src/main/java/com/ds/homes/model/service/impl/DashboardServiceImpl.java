package com.ds.homes.model.service.impl;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.BankBookDetail;
import com.ds.homes.model.mapper.DashboardMapper;
import com.ds.homes.model.service.DashboardService;
import com.ds.homes.tools.constant.UserConstant;
import com.ds.homes.tools.util.DateUtil;
import com.ds.homes.tools.util.ResponseUtil;

@Service
public class DashboardServiceImpl implements DashboardService {

	@Autowired
	private DashboardMapper dashboardMapper;
	
	/**
	 * 대시보드 목록 조회 
	 */
	@Override
	public Map<String, Object> selectChart() {
		Map<String, Object> resultMap = null;
		
		try {
			BankBookDetail bankBookDetail = new BankBookDetail();
			Integer homeIdx = UserConstant.getUser().getHomeIdx();
			
			bankBookDetail.setHomeIdx(homeIdx);
			bankBookDetail.setAmountDateStr(DateUtil.dateToString(new Date(), "yyyyMM"));
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("list"			, dashboardMapper.selectChart(bankBookDetail));
			resultMap.put("remainAmount"	, dashboardMapper.selectOfBankBook(homeIdx));
			resultMap.put("totalAssets"		, dashboardMapper.selectTotalAssets(homeIdx));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
}
