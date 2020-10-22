package com.ds.homes.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.homes.model.AccountBook;
import com.ds.homes.model.dto.AccountBookDTO;
import com.ds.homes.model.dto.PagingDTO;
import com.ds.homes.model.service.AccountBookService;

/**
 * 가계부 Controller
 * 
 * @author idaesan
 *
 */
@RestController
@RequestMapping("/rest/accountBook")
public class AccountBookRestController {
	
	@Autowired
	private AccountBookService accountBookService;
	
	/**
	 * 가계부 목록 조회 Controller
	 * 
	 * @param pagingDTO
	 * @param accountBook
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list (PagingDTO<AccountBook> pagingDTO, AccountBook accountBook) {
		pagingDTO.setModel(accountBook);
		return accountBookService.select(pagingDTO);
	}
	
	/**
	 * 가계부 등록, 수정, 삭제 Controller
	 * 
	 * @param accountBookDTO
	 * @param type
	 * @return
	 */
	@PostMapping("/merge")
	public Map<String, Object> merge (AccountBookDTO accountBookDTO, @RequestParam(value = "type") String type) {
		return accountBookService.merge(accountBookDTO, type);
	}

	/**
	 * 가계 정산 목록 조회 Controller
	 * 
	 * @param accountBook
	 * @return
	 */
	@PostMapping("/calculate/list")
	public Map<String, Object> calculateList (AccountBook accountBook) {
		return accountBookService.calculateList(accountBook);
	}
}
