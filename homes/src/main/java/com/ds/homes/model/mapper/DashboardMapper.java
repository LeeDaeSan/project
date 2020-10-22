package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.BankBookDetail;
import com.ds.homes.model.CheckMemo;
import com.ds.homes.model.dto.CheckMemoDTO;
import com.ds.homes.model.dto.DashboardDTO;

/**
 * Dashboard Mapper
 * 
 * @author idaesan
 */
@Mapper
public interface DashboardMapper {

	/**
	 * 최상단 통계
	 * 
	 * @return
	 */
	public DashboardDTO getTotalAmount();
	
	/**
	 * 대시보드 차트 목록 Mapper
	 * 
	 * @param homeIdx
	 * @return
	 */
	public List<DashboardDTO> selectChart(BankBookDetail bankBookDetail);
	
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
	
	/**
	 * 금일 체크 목록 조회
	 * 
	 * @param checkMemo
	 * @return
	 */
	public List<CheckMemo> selectTodayCheckMemoList(CheckMemoDTO checkMemoDTO);
}
