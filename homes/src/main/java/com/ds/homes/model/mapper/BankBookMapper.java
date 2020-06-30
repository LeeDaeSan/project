package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.BankBook;
import com.ds.homes.model.dto.PagingDTO;

@Mapper
public interface BankBookMapper {

	/**
	 * 가계부 목록 조회
	 * 
	 * @param bankBook
	 */
	public List<BankBook> list(PagingDTO<BankBook> pagingDTO);
	
	/**
	 * 가계부 목록 total count
	 * 
	 * @param bankBook
	 * @return
	 */
	public Long listOfTotalCount(PagingDTO<BankBook> pagingDTO);
	
	/**
	 * 가계부 등록
	 * 
	 * @param bankBook
	 * @return
	 */
	public Integer insert(BankBook bankBook);
	
	/**
	 * 가계부 수정
	 * 
	 * @param bankBook
	 * @return
	 */
	public Integer update(BankBook bankBook);
	
	/**
	 * 통장 삭제
	 * 
	 * @param bankBookIdx
	 * @return
	 */
	public Integer delete(Integer bankBookIdx);
	
	/**
	 * 가계부 수정
	 *  -> 총금액 수정
	 *  
	 * @param bankBook
	 * @return
	 */
	public Integer updateForTotalAmount(BankBook bankBook);
	
	/**
	 * 가계부 상세 조회
	 * 
	 * @param bankBookIdx
	 * @return
	 */
	public BankBook detail(Integer bankBookIdx);
	
	/**
	 * 메인 통장 정보 조회
	 * 
	 * @param bankBook
	 * @return
	 */
	public BankBook selectOfMainType(BankBook bankBook);
}
