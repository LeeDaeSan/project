package com.dshome.system.cashflow.service;

import java.util.Map;

import com.dshome.system.model.CashFlow;
import com.dshome.system.model.dto.PagingDTO;

/**
 * 현금흐름표 정보 Service
 * 
 * @author daesan
 *
 */
public interface CashFlowService {

	/**
	 * 현금흐름표 목록 조회
	 * 
	 * @param pagingDTO
	 * @return
	 */
	public Map<String, Object> select(PagingDTO<CashFlow> pagingDTO);
	
	/**
	 * 현금흐름표 등록, 수정, 삭제
	 * 
	 * @param cashFlow
	 * @param type
	 * @return
	 */
	public Map<String, Object> merge(CashFlow cashFlow, String type);
}
