package com.ds.homes.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ds.homes.model.service.DashboardService;

/**
 * Dashboard Controller
 * 
 * @author idaesan
 */
@RestController
@RequestMapping("/rest/dashboard")
public class DashboardRestController {

	@Autowired
	private DashboardService dashboardService;
	
	/**
	 * 대시보드 목록 조회 Controller
	 * 
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> selectChart () {
		return dashboardService.selectChart();
	}
	
	/**
	 * 대시보드 금일 체크 목록 조회 Controller
	 * 
	 * @return
	 */
	@PostMapping("/checkMemo/daily")
	public Map<String, Object> selectCheckMemoToday () {
		return dashboardService.selectTodayCheckMemoList();
	}
}
