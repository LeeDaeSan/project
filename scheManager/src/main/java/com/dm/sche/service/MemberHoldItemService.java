package com.dm.sche.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.MemberHoldItem;

@Service
public interface MemberHoldItemService {

	/**
	 * 사용자 가계 목록
	 * @param memberHoldItem
	 * @return
	 */
	public Map<String, Object> select (String holdDateStr, PagingDTO<MemberHoldItem> pagingDTO);
	
	/**
	 * 사용자 가계 등록
	 * @param memberHoldItem
	 */
	public Map<String, Object> merge(String mergeType, String holdDateStr, MemberHoldItem memberHoldItem);
}
