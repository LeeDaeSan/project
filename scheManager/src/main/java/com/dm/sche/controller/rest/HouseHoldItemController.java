package com.dm.sche.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.HouseHoldItem;
import com.dm.sche.service.HouseHoldItemService;

@RestController
@RequestMapping("/houseHoldItem")
public class HouseHoldItemController {

	@Autowired
	private HouseHoldItemService houseHoldItemService;
	
	/**
	 * 대분류 항목 정보 조회
	 * 
	 * @return
	 */
	@PostMapping(value = "/list")
	public Map<String, Object> list (PagingDTO<HouseHoldItem> pagingDTO, HouseHoldItem houseHoldItem) {
		pagingDTO.setModel(houseHoldItem);
		
		return houseHoldItemService.select(pagingDTO);
	}
	
	/**
	 * 마지막 코드번호 조회
	 * 
	 * @param level
	 * @return
	 */
	@PostMapping(value = "/nextCode")
	public Map<String, Object> selectOfNextCode (HouseHoldItem houseHoldItem) {
		return houseHoldItemService.selectOfNextCode(houseHoldItem);
	}
	
	/**
	 * 대분류 항목 상세 정보 조회
	 * 
	 * @param itemIdx
	 * @return
	 */
	@PostMapping(value = "/detail")
	public Map<String, Object> detail (@RequestParam(value = "itemIdx", required = true) int itemIdx) {
		return houseHoldItemService.detail(itemIdx);
	}
	
	/**
	 * 품목명 중복확인
	 * 
	 * @param itemName
	 * @return
	 */
	@PostMapping(value = "/nameChk")
	public String nameChk (KeywordDTO keywordDTO) {
		return houseHoldItemService.keywordCheck(keywordDTO);
	}
	
	/**
	 * 대분류 항목 정보 등록, 수정, 삭제
	 * 
	 * @return
	 */
	@PostMapping(value = "/merge")
	public Map<String, Object> merge (@RequestParam(value = "type", required = false) String type, 
						HouseHoldItem houseHoldItem) {
		
		return houseHoldItemService.merge(type, houseHoldItem);
	}
	
	/**
	 * 가계 등록시 조회되는 코드 항목 목록
	 * 
	 * @param pagingDTO
	 * @return
	 */
	@PostMapping(value = "/selectOfPopup")
	public Map<String, Object> select (PagingDTO<HouseHoldItem> pagingDTO, HouseHoldItem houseHoldItem) {
		pagingDTO.setModel(houseHoldItem);
		
		return houseHoldItemService.selectOfPopup(pagingDTO);
	}

	/**
	 * 가계 코드기준 통계 목록
	 * 
	 * @param keywordDTO
	 * @return
	 */
	@PostMapping(value = "/selectOfStatistics")
	public Map<String, Object> stat (PagingDTO<HouseHoldItem> pagingDTO) {
		return houseHoldItemService.selectOfStatistics(pagingDTO);
	}
}
