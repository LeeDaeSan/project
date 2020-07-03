package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.dto.DashboardDTO;

/**
 * Dashboard Mapper
 * 
 * @author idaesan
 */
@Mapper
public interface DashboardMapper {

	/**
	 * 대시보드 차트 목록 Mapper
	 * 
	 * @param homeIdx
	 * @return
	 */
	public List<DashboardDTO> selectChart(Integer homeIdx);
	
	/**
	 * 현재월 기준 가계 통장의 남은 잔액 Mapper
	 * 
	 * @param homeIdx
	 * @return
	 */
	public Double selectOfBankBook(Integer homeIdx);
	
	/**
	 * 총 자산 조회 Mapper
	 * 
	 * @param homeIdx
	 * @return
	 */
	public Double selectTotalAssets(Integer homeIdx);
}
