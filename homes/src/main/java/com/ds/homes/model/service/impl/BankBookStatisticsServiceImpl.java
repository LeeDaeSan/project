package com.ds.homes.model.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.BankBookStatistics;
import com.ds.homes.model.dto.BankBookStatisticsDetailDTO;
import com.ds.homes.model.mapper.BankBookStatisticsDetailMapper;
import com.ds.homes.model.mapper.BankBookStatisticsMapper;
import com.ds.homes.model.service.BankBookStatisticsService;
import com.ds.homes.tools.constant.Constant;
import com.ds.homes.tools.constant.UserConstant;
import com.ds.homes.tools.util.DateUtil;
import com.ds.homes.tools.util.ResponseUtil;

@Service
public class BankBookStatisticsServiceImpl implements BankBookStatisticsService {
	
	@Autowired
	private BankBookStatisticsMapper bankBookStatisticsMapper;
	@Autowired
	private BankBookStatisticsDetailMapper bankBookStatisticsDetailMapper;

	/**
	 * 정산 목록 조회 Business
	 * 
	 */
	@Override
	public Map<String, Object> select(BankBookStatistics bankBookStatistics) {
		Map<String, Object> resultMap = null;
		
		try {
			bankBookStatistics.setHomeIdx(UserConstant.getUser().getHomeIdx());
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", bankBookStatisticsMapper.select(bankBookStatistics));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		return resultMap;
	}
	
	/**
	 * 정산 조회 Business
	 * 
	 */
	@Override
	public Map<String, Object> detail(BankBookStatistics bankBookStatistics) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			bankBookStatistics.setHomeIdx(UserConstant.getUser().getHomeIdx());
			
			resultMap.put("detail", bankBookStatisticsMapper.detail(bankBookStatistics));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	/**
	 * 정산 등록, 삭제 Business
	 * 
	 */
	@Override
	public Map<String, Object> merge(BankBookStatistics bankBookStatistics, String amountDateStr, String type) {
		Map<String, Object> resultMap = null;
		Integer result = 0;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			// 등록
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				Integer homeIdx = UserConstant.getUser().getHomeIdx();
				
				// 정산 파라미터 셋팅
				bankBookStatistics.setHomeIdx(homeIdx);
				bankBookStatistics.setStatisticsDate(DateUtil.stringToDate(bankBookStatistics.getStaticticsDateStr(), "yyyy-MM-dd"));
				bankBookStatistics.setStatisticsRealDate(amountDateStr);
				// 정산 등록
				result = bankBookStatisticsMapper.insert(bankBookStatistics);
				
				// 정산 상세 파라미터 셋팅
				BankBookStatisticsDetailDTO bankBookStatisticsDetailDTO = new BankBookStatisticsDetailDTO();
				bankBookStatisticsDetailDTO.setHomeIdx(homeIdx);
				bankBookStatisticsDetailDTO.setStatisticsIdx(bankBookStatistics.getStatisticsIdx());
				bankBookStatisticsDetailDTO.setAmountDateStr(amountDateStr);
				// 정산 상세 등록
				result = bankBookStatisticsDetailMapper.insert(bankBookStatisticsDetailDTO);
				
			// 삭제
			} else if (Constant.MERGE_TYPE_DELETE.equals(type)) {
				
				// 정산 상세 삭제
				result = bankBookStatisticsDetailMapper.delete(bankBookStatistics);
				// 정산 삭제
				result = bankBookStatisticsMapper.delete(bankBookStatistics);
			}
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		resultMap.put("resultCount", result);
		
		return resultMap;
	}
}
