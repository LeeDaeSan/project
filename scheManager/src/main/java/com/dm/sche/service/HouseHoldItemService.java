package com.dm.sche.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.HouseHoldItem;

@Service
public interface HouseHoldItemService {

	/**
	 * 대분류 항목 정보 조회
	 * 
	 * @return
	 */
	public Map<String, Object> select(PagingDTO<HouseHoldItem> pagingDTO);
	
	/**
	 * 마지막 코드번호 조회
	 * 
	 * @param level
	 * @return
	 */
	public Map<String, Object> selectOfNextCode(HouseHoldItem houseHoldItem);
	
	/**
	 * 대분류 항목 상세 정보 조회
	 * 
	 * @param itemIdx
	 * @return
	 */
	public Map<String, Object> detail(int itemIdx);
	
	/**
	 * 대분류 항목 정보 등록, 수정, 삭제
	 * 
	 * @param houseHoldItem
	 * @return
	 */
	public Map<String, Object> merge(String type, HouseHoldItem houseHoldItem);
	
	/**
	 * 대분류 등록, 수정시 중복확인
	 * 
	 * @param keywordDTO
	 * @return
	 */
	public String keywordCheck(KeywordDTO keywordDTO);
	
	/**
	 * 가계 등록시 조회되는 대분류 항목 목록
	 * @return
	 */
	public Map<String, Object> selectOfPopup(PagingDTO<HouseHoldItem> pagingDTO);
	
	/**
	 * 
	 * @param keywordDTO
	 * @return
	 */
	public Map<String, Object> selectOfStatistics(PagingDTO<HouseHoldItem> pagingDTO);
}
