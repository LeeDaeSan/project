package com.homes.ds.contoller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.homes.ds.dto.PagingDTO;
import com.homes.ds.model.BankBook;
import com.homes.ds.service.BankBookService;

/**
 * 가계부 Controller
 * 
 * @author idaesan
 *
 */
@RestController
@RequestMapping("/rest/bankBook")
public class BankBookRestController {

	@Autowired
	private BankBookService bankBookService;
	
	/**
	 * 가계부 목록 조회 Controller
	 * 
	 * @param bankBook
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list (PagingDTO<BankBook> pagingDTO, BankBook bankBook) {
		pagingDTO.setModel(bankBook);
		return bankBookService.list(pagingDTO);
	}
	
	/**
	 * 가계부 상세 정보 조회 Controller
	 * 
	 * @param bankBook
	 * @return
	 */
	@PostMapping("/detail")
	public Map<String, Object> detail (BankBook bankBook) {
		return bankBookService.detail(bankBook.getBankBookIdx());
	}
	
	/**
	 * 가계부 저장 Controller
	 * 
	 * @param bankBook
	 * @param type
	 * @return
	 */
	@PostMapping("/merge")
	public Map<String, Object> merge (BankBook bankBook, @RequestParam(value = "type") String type) {
		return bankBookService.merge(bankBook, type);
	}
	
	/**
	 * 메인통장 정보 조회 Controller
	 * 
	 * @param bankBook
	 * @return
	 */
	@PostMapping("/main")
	public Map<String, Object> selectOfMainType (BankBook bankBook) {
		return bankBookService.selectOfMainType(bankBook);
	}
}
