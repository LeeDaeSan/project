package com.dshome.system.model.cashflow.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dshome.system.model.CashFlow;
import com.dshome.system.model.dto.CashFlowDTO;
import com.dshome.system.model.dto.PagingDTO;

/**
 * 사용자 현금흐름표 정보 Mapper
 * 
 * @author daesan
 *
 */
@Mapper
public interface CashFlowMapper {

	/**
	 * 사용자 현금흐름표 정보 목록 조회
	 * 
	 * @param pagingDTO
	 * @return
	 */
	public List<CashFlow> select(PagingDTO<CashFlow> pagingDTO);
	
	/**
	 * 사용자 현금흐름표 통계 정보 목록 조회
	 * 
	 * @param pagingDTO
	 * @return
	 */
	public List<CashFlowDTO> selectOfStatistics(PagingDTO<CashFlow> pagingDTO);
	
	/**
	 * 사용자 현금흐름표 정보 등록
	 * 
	 * @param cashFlow
	 * @return
	 */
	public Integer insert(CashFlow cashFlow);
}
