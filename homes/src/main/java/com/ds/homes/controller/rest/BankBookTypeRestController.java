package com.ds.homes.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ds.homes.model.service.BankBookTypeService;

/**
 * 통장 유형 정보 Controller
 * 
 * @author idaesan
 *
 */
@RestController
@RequestMapping("/rest/bankBookType")
public class BankBookTypeRestController {

	@Autowired
	private BankBookTypeService bankBookTypeService;
	
	/**
	 * 통장 유형 목록 조회 Rest Controller
	 * 
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list () {
		return bankBookTypeService.select();
	}
}
