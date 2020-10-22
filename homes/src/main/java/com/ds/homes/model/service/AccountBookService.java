package com.ds.homes.model.service;

import java.util.Map;

import com.ds.homes.model.AccountBook;
import com.ds.homes.model.dto.AccountBookDTO;
import com.ds.homes.model.dto.PagingDTO;

/**
 * 가계부 Service
 * 
 * @author idaesan
 *
 */
public interface AccountBookService {

	/**
	 * 가계부 목록 조회 Service
	 * 
	 * @param pagingDTO
	 * @return
	 */
	public Map<String, Object> select(PagingDTO<AccountBook> pagingDTO);
	
	/**
	 * 가계부 등록, 수정, 삭제 Service
	 * 
	 * @param accountBookDTO
	 * @param type
	 * @return
	 */
	public Map<String, Object> merge(AccountBookDTO accountBookDTO, String type);
	
	/**
	 * 가계 정산 조회 Service
	 * 
	 * @param accountBook
	 * @return
	 */
	public Map<String, Object> calculateList(AccountBook accountBook);
}
