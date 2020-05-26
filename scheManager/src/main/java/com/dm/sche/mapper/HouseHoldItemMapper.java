package com.dm.sche.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.dto.PagingDTO;
import com.dm.sche.dto.StatisticsDTO;
import com.dm.sche.model.HouseHoldItem;

@Mapper
public interface HouseHoldItemMapper {

	/**
	 * 대분류 항목 목록 조회
	 * @param pagingDTO
	 * @return
	 */
	public List<HouseHoldItem> select(PagingDTO<HouseHoldItem> pagingDTO);
	
	/**
	 * 마지막 코드번호 조회
	 * @param level
	 * @return
	 */
	public String selectOfNextCode(HouseHoldItem houseHoldItem);
	
	/**
	 * 대분류 항목 정보 total count
	 * @return
	 */
	public Long selectForTotalcount(PagingDTO<HouseHoldItem> pagingDTO);
	
	/**
	 * 대분류 항목 상세 정보 조회
	 * 
	 * @param itemIdx
	 * @return
	 */
	public HouseHoldItem detail(int itemIdx);
	
	/**
	 * 대분류 항목 정보 등록
	 * 
	 * @param houseHoldItem
	 * @return
	 */
	public Integer insert(HouseHoldItem houseHoldItem);
	
	/**
	 * 대분류 항목 정보 수정
	 * @param itemIdx
	 * @return
	 */
	public Integer update(HouseHoldItem houseHoldItem);
	
	/**
	 * 대분류 등록, 수정시 중복확인
	 * 
	 * @param keywordDTO
	 * @return
	 */
	public String keywordCheck(KeywordDTO keywordDTO);
	
	/**
	 * 대분류 정보 삭제
	 * @param itemIdx
	 * @return
	 */
	public Integer delete(int itemIdx);
	
	/**
	 * 가계 등록시 조회되는 대분류 항목 목록
	 * @return
	 */
	public List<HouseHoldItem> selectOfPopup(PagingDTO<HouseHoldItem> pagingDTO);
	
	/**
	 * 가계 코드기준 통계 목록
	 * 
	 * @param pagingDTO
	 * @return
	 */
	public List<StatisticsDTO> selectOfStatistics(PagingDTO<HouseHoldItem> pagingDTO);
	
}
