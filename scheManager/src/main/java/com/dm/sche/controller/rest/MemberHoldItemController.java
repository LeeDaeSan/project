package com.dm.sche.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.MemberHoldItem;
import com.dm.sche.service.MemberHoldItemService;

@RestController
@RequestMapping("/memberHoldItem")
public class MemberHoldItemController {

	@Autowired
	private MemberHoldItemService memberHoldItemService;
	
	/**
	 * 사용자 가계 목록 조회
	 * @param memberHoldItem
	 * @return
	 */
	@PostMapping(value = "/list")
	public Map<String, Object> list (@RequestParam(value = "holdDateStr", required = false) String holdDateStr,
									PagingDTO<MemberHoldItem> pagingDTO) {
		
		return memberHoldItemService.select(holdDateStr, pagingDTO);
	}
	
	/**
	 * 사용자 가계 등록, 수정, 삭제
	 * @param mergeType
	 * @param memberHoldItem
	 * @return
	 */
	@PostMapping(value = "/merge")
	public Map<String, Object> merge (@RequestParam(value = "mergeType", required = false) String mergeType,
									  @RequestParam(value = "holdDateStr", required = false) String holdDateStr,
									  MemberHoldItem memberHoldItem) {
		
		return memberHoldItemService.merge(mergeType, holdDateStr, memberHoldItem);
	}
	
}
