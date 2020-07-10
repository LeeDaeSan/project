package com.ds.homes.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.BankBookStatistics;
import com.ds.homes.model.dto.BankBookStatisticsDetailDTO;

@Mapper
public interface BankBookStatisticsDetailMapper {

	/**
	 * 정산 통계 상세 등록 Mapper
	 * 
	 * @param bankBookStatisticsDetailDTO
	 * @return
	 */
	public Integer insert(BankBookStatisticsDetailDTO bankBookStatisticsDetailDTO);
	
	/**
	 * 정산 상세 내역 삭제 Mapper
	 * 
	 * @param bankBookStatistics
	 * @return
	 */
	public Integer delete(BankBookStatistics bankBookStatistics);
}
