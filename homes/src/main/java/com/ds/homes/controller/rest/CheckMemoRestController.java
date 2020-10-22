package com.ds.homes.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.homes.model.CheckMemo;
import com.ds.homes.model.dto.CheckMemoDTO;
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
	public Map<String, Object> merge (CheckMemoDTO checkMemoDTO, @RequestParam(value = "type") String type) {
		return checkMemoService.merge(checkMemoDTO, type);
	}
	
	/**
	 * 체크 메모 checked / unchecked Controller
	 * 
	 * @param checkMemo
	 * @return
	 */
	@PostMapping("/isChecked")
	public Map<String, Object> isChecked (CheckMemo checkMemo) {
		return checkMemoService.isChecked(checkMemo);
	}
	
	/**
	 * 체크 메모 정보 삭제 Controller
	 * 
	 * @param checkMemoIdx
	 * @return
	 */
	@PostMapping("/delete")
	public Map<String, Object> delete (@RequestParam(value = "checkMemoIdx") Integer checkMemoIdx) {
		return checkMemoService.delete(checkMemoIdx);
	}
}
