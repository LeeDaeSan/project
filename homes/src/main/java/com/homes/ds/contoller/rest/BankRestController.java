package com.homes.ds.contoller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.homes.ds.service.BankService;

@RestController
@RequestMapping("/bank")
public class BankRestController {
	
	@Autowired
	private BankService bankService;
	
	/**
	 * 은행 목록 조회
	 * 
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list () {
		return bankService.list();
	}

}
