package com.ds.estate.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ds.estate.model.service.LineKindsService;

@RestController
@RequestMapping("/rest/lineKinds")
public class LineKindsRestController {

	@Autowired
	private LineKindsService lineKindsService;
	
	/**
	 * 라인 유형 목록 조회 Controller
	 * 
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list () {
		return lineKindsService.list(); 
	}
}
