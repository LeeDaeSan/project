package com.dm.sche.service;

import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface HouseHoldItemDetailService {

	/**
	 * 대분류 항목 상세 목록 조회
	 * @param pagingDTO
	 * @return
	 */
	public Map<String, Object> select(int itemIdx);
}
