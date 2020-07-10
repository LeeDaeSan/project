package com.ds.homes.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.homes.model.BankBookStatistics;
import com.ds.homes.model.service.BankBookStatisticsService;

/**
 * 정산 통계 Controller
 * 
 * @author idaesan
 *
 */
@RestController
@RequestMapping("/rest/statistics")
public class BankBookStatisticsRestController {
	
	@Autowired
	private BankBookStatisticsService bankBookStatisticsService;

	/**
	 * 정산 목록 조회 Controller
	 * 
	 * @param bankBookStatistics
	 * @return
	 */
	@PostMapping("/select")
	public Map<String, Object> select (BankBookStatistics bankBookStatistics) {
		return bankBookStatisticsService.select(bankBookStatistics);
	}
	
	/**
	 * 정산 조회 Controller
	 * 
	 * @param bankBookStatistics
	 * @return
	 */
	@PostMapping("/detail")
	public Map<String, Object> detail (BankBookStatistics bankBookStatistics) {
		return bankBookStatisticsService.detail(bankBookStatistics);
	}

	/**
	 * 정산 통계 저장 Controller
	 * 
	 * @param bankBookStatistics
	 * @param amountDateStr
	 * @return
	 */
	@PostMapping("/merge")
	public Map<String, Object> merge (BankBookStatistics bankBookStatistics, 
				@RequestParam(value = "amountDateStr", required = false) String amountDateStr,
				@RequestParam(value = "type") String type) {
		return bankBookStatisticsService.merge(bankBookStatistics, amountDateStr, type);
	}
}
