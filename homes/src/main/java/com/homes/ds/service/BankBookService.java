package com.homes.ds.service;

import java.util.Map;

import com.homes.ds.dto.PagingDTO;
import com.homes.ds.model.BankBook;

public interface BankBookService {

	/**
	 * 가계부 목록 조회 Service
	 * 
	 * @return
	 */
	public Map<String, Object> list(PagingDTO<BankBook> pagingDTO);
	
	/**
	 * 가계부 저장 Service
	 * type I : 등록, U : 수정, D : 삭제
	 * 
	 * @param bankBook
	 * @return
	 */
	public Map<String, Object> merge(BankBook bankBook, String type);
	
	/**
	 * 가계부 상세 정보 조회 Service
	 * 
	 * @param bankBookIdx
	 * @return
	 */
	public Map<String, Object> detail(Integer bankBookIdx);
	
	/**
	 * 메인통장 정보 조회 Service
	 * 
	 * @param bankBook
	 * @return
	 */
	public Map<String, Object> selectOfMainType(BankBook bankBook);
}
