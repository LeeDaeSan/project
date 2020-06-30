package com.ds.homes.model.service;

import java.util.Map;

public interface DashboardService {

	/**
	 * 대시보드 차트 목록 조회 Service
	 * 
	 * @return
	 */
	public Map<String, Object> selectChart();
}
