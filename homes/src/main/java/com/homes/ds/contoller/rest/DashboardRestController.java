package com.homes.ds.contoller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.homes.ds.service.DashboardService;

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
}
