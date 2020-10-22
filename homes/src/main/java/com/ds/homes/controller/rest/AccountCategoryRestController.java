package com.ds.homes.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.homes.model.AccountCategory;
import com.ds.homes.model.service.AccountCategoryService;

@RestController
@RequestMapping("/rest/accountCategory")
public class AccountCategoryRestController {

	@Autowired
	private AccountCategoryService accountCategoryService;
	
	/**
	 * 가계부 분류코드 목록 조회 Controller
	 * 
	 * @param accountCategory
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list (AccountCategory accountCategory) {
		return accountCategoryService.list(accountCategory);
	}
	
	/**
	 * 가계부에서 조회할 목록 Controller
	 * 
	 * @param accountCategory
	 * @return
	 */
	@PostMapping("/listOfAccountBank")
	public Map<String, Object> listOfAccountBook (AccountCategory accountCategory) {
		return accountCategoryService.listOfAccountBook(accountCategory);
	}
	
	/**
	 * 가계부 분류코드 등록, 수정, 삭제 Controller
	 * 
	 * @param accountCategory
	 * @param type
	 * @return
	 */
	@PostMapping("/merge")
	public Map<String, Object> merge (AccountCategory accountCategory, @RequestParam(value = "type") String type) {
		return accountCategoryService.merge(accountCategory, type);
	}
}
