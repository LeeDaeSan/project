package com.homes.ds.contoller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.homes.ds.model.BankBook;
import com.homes.ds.service.BankBookService;

/**
 * 가계부 Controller
 * 
 * @author idaesan
 *
 */
@RestController
@RequestMapping("/bankBook")
public class BankBookController {

	@Autowired
	private BankBookService bankBookService;
	
	/**
	 * 가계부 목록 조회
	 * 
	 * @param bankBook
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list (BankBook bankBook) {
		return bankBookService.list(bankBook);
	}
}
