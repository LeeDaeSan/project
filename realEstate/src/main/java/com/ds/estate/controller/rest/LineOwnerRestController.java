package com.ds.estate.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.estate.model.LineOwner;
import com.ds.estate.model.service.LineOwnerService;

/**
 * 라인정보 Rest Controller
 * 
 * @author idaesan
 */
@RestController
@RequestMapping("/rest/lineOwner")
public class LineOwnerRestController {

	@Autowired
	private LineOwnerService lineOwnerService;
	
	/**
	 * 라인정보 목록 조회
	 * 
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list () {
		return lineOwnerService.list();
	}
	
	/**
	 * 라인정보 등록, 수정, 삭제
	 * 
	 * @param lineOwner
	 * @param type
	 * @return
	 */
	@PostMapping("/merge")
	public Map<String, Object> merge (LineOwner lineOwner, @RequestParam(value = "type") String type) {
		return lineOwnerService.merge(lineOwner, type);
	}
}
