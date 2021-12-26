package com.dshome.system.cashflow.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dshome.system.cashflow.service.CashFlowService;
import com.dshome.system.model.CashFlow;
import com.dshome.system.model.dto.PagingDTO;

/**
 * 현금흐름표 Rest Controller
 * 
 * @author daesan
 *
 */
@RestController
@RequestMapping("/rest/cashflow")
public class CashFlowRestController {

	@Autowired
	private CashFlowService cashFlowService;
	
	/**
	 * 사용자 현금흐름표 목록 조회 Controller
	 * 
	 * @param pagingDTO
	 * @param cashFlow
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list(PagingDTO<CashFlow> pagingDTO, CashFlow cashFlow) {
		pagingDTO.setModel(cashFlow);
		return cashFlowService.select(pagingDTO);
	}
	
	/**
	 * 사용자 현금흐름표 등록, 수정, 삭제 Controller
	 * 
	 * @param cashFlow
	 * @param type
	 * @return
	 */
	@PostMapping("/merge")
	public Map<String, Object> merge(CashFlow cashFlow, @RequestParam("mergeType") String type) {
		return cashFlowService.merge(cashFlow, type);
	}
}
