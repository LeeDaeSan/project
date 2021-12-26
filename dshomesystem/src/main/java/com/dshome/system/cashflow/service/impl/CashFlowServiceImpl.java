package com.dshome.system.cashflow.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dshome.system.cashflow.service.CashFlowService;
import com.dshome.system.etc.constant.Constant;
import com.dshome.system.etc.util.DateUtil;
import com.dshome.system.etc.util.ResponseUtil;
import com.dshome.system.model.CashFlow;
import com.dshome.system.model.cashflow.mapper.CashFlowMapper;
import com.dshome.system.model.dto.PagingDTO;

/**
 * 사용자 현금흐름표 정보 Service Implements
 * 
 * @author daesan
 *
 */
@Service
public class CashFlowServiceImpl implements CashFlowService {

	@Autowired
	private CashFlowMapper cashFlowMapper;
	
	/**
	 * 현금흐름표 목록 정보 조회
	 * 
	 */
	@Override
	public Map<String, Object> select(PagingDTO<CashFlow> pagingDTO) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			CashFlow cashFlow = pagingDTO.getModel();
			
			// 현금흐름표 수익 목록
			cashFlow.setFlowType(Constant.CASHFLOW_TYPE_INCOME);
			pagingDTO.setModel(cashFlow);
			resultMap.put("incomeList", cashFlowMapper.select(pagingDTO));
			
			// 현금흐름표 지출 목록
			cashFlow.setFlowType(Constant.CASHFLOW_TYPE_EXPENDITURE);
			pagingDTO.setModel(cashFlow);
			resultMap.put("expendList", cashFlowMapper.select(pagingDTO));
			
			// 현금흐름표 지출 기준 통계 조회
			cashFlow.setFlowType(Constant.CASHFLOW_TYPE_EXPENDITURE);
			pagingDTO.setModel(cashFlow);
			resultMap.put("statisticsList", cashFlowMapper.selectOfStatistics(pagingDTO));
			
		} catch (Exception e) {
			e.printStackTrace();
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	/**
	 * 현금흐름표 등록, 수정, 삭제
	 * 
	 */
	@Override
	public Map<String, Object> merge(CashFlow cashFlow, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			cashFlow.setMemberIdx(1);
			
			// 등록
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				cashFlow.setFlowDate(DateUtil.stringToDate(cashFlow.getFlowDateStr(), "yyyy-MM-dd"));
				resultMap.put("resultCount", cashFlowMapper.insert(cashFlow));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
}
