package com.dm.sche.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dm.sche.service.HouseHoldItemDetailService;

@RestController
@RequestMapping("/houseHoldItemDetail")
public class HouseHoldItemDetailController {

	@Autowired
	private HouseHoldItemDetailService houseHoldItemDetailService;
	
	/**
	 * 대분류 항목 상세 목록 조회
	 * @param itemIdx
	 * @return
	 */
	@PostMapping(value = "/list")
	public Map<String, Object> list (@RequestParam(value = "itemIdx", required = true) int itemIdx) {
		return houseHoldItemDetailService.select(itemIdx);
	}
}
