package com.ds.homes.model.service;

import java.util.Map;

import com.ds.homes.model.BankBookStatistics;

public interface BankBookStatisticsService {

	/**
	 * 정산 목록 조회 Service
	 * 
	 * @param bankBookStatistics
	 * @return
	 */
	public Map<String, Object> select (BankBookStatistics bankBookStatistics);
	
	/**
	 * 정산 조회 Service
	 * 
	 * @param bankBookStatistics
	 * @return
	 */
	public Map<String, Object> detail (BankBookStatistics bankBookStatistics);
	
	/**
	 * 정산 통계 등록 Service
	 * 
	 * @param bankBookStatistics
	 * @return
	 */
	public Map<String, Object> merge (BankBookStatistics bankBookStatistics, String amountDateStr, String type);
	
}
