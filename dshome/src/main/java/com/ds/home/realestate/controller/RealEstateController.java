package com.ds.home.realestate.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.home.model.MemberRealEstate;
import com.ds.home.realestate.service.RealEstateService;

/**
 * 부동산 Rest Controller
 * 
 * @author daesan
 *
 */
@RestController
@RequestMapping("/realEstate")
public class RealEstateController {
	
	private static final Logger logger = LoggerFactory.getLogger(RealEstateController.class);
	
	@Autowired
	private RealEstateService realEstateService;
	
	/**
	 * 사용자 부동산 목록 Controller
	 * 
	 * @param cityLocation
	 * @return
	 */
	@GetMapping("/list")
	public Map<String, Object> list(MemberRealEstate memberRealEstate){
		return realEstateService.select(memberRealEstate);
	}
	
	/**
	 * 부동산 상세 Controller
	 * 
	 */
	@PostMapping("/detail")
	public void detail () {
	}
	
	/**
	 * 부동산 등록, 수정, 삭제 Controller
	 * 
	 * @param type
	 */
	@PostMapping("/merge")
	public void merge(@RequestParam("type") String type) {
	}
	
}
