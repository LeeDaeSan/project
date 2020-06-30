package com.ds.homes.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.homes.model.CheckList;
import com.ds.homes.model.CheckMemo;
import com.ds.homes.model.service.CheckMemoService;

@RestController
@RequestMapping("/rest/checkMemo")
public class CheckMemoRestController {

	@Autowired
	private CheckMemoService checkMemoService;
	
	/**
	 * 체크 메모 정보 조회 Controller
	 * @param checkMemo
	 * @return
	 */
	@PostMapping("/info")
	public Map<String, Object> info (CheckMemo checkMemo) {
		return checkMemoService.select(checkMemo);
	}
	
	/**
	 * 체크 메모 정보 저장 Controller
	 *  -> 등록, 수정
	 *  
	 * @param checkMemo
	 * @param type
	 * @return
	 */
	@PostMapping("/merge")
	public Map<String, Object> merge (CheckMemo checkMemo, @RequestParam(value = "type") String type) {
		return checkMemoService.merge(checkMemo, type);
	}
	
	/**
	 * 체크리스트 check / uncheck update Controller
	 * 
	 * @param checkList
	 * @return
	 */
	@PostMapping("/checked")
	public Map<String, Object> checked (CheckList checkList) {
		return checkMemoService.checked(checkList);
	}
	
	/**
	 * 체크리스트 수정, 삭제 Controller
	 * 
	 * @param checkList
	 * @return
	 */
	@PostMapping("/checkList/merge")
	public Map<String, Object> merge (CheckList checkList, @RequestParam(value = "type") String type) {
		return checkMemoService.merge(checkList, type);
	}
}
