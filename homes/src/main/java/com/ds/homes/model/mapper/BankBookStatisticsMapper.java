package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.BankBookStatistics;

@Mapper
public interface BankBookStatisticsMapper {

	/**
	 * 정산 목록 조회 Mapper
	 * 
	 * @param bankBookStatistics
	 * @return
	 */
	public List<BankBookStatistics> select(BankBookStatistics bankBookStatistics);
	
	/**
	 * 정산 조회 Mapper
	 * 
	 * @param bankBookStatistics
	 * @return
	 */
	public BankBookStatistics detail(BankBookStatistics bankBookStatistics);
	
	/**
	 * 월말 정산 통계 등록 Mapper
	 *  
	 * @param bankBookStatistics
	 * @return
	 */
	public Integer insert(BankBookStatistics bankBookStatistics);
	
	/**
	 * 정산 삭제 Mapper
	 * 
	 * @param bankBookStatistics
	 * @return
	 */
	public Integer delete(BankBookStatistics bankBookStatistics);
}
