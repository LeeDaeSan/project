package com.ds.homes.model.service;

import java.util.Map;

import com.ds.homes.model.BankBookDetail;
import com.ds.homes.model.dto.BankBookDetailDTO;
import com.ds.homes.model.dto.PagingDTO;

public interface BankBookDetailService {

	/**
	 * 가계 상세 정보 목록 조회 Service
	 * 
	 * @param bankBookDetail
	 * @return
	 */
	public Map<String, Object> list(PagingDTO<BankBookDetail> pagingDTO);
	
	/**
	 * 가계 상세의 상세 정보 조회 Service
	 * 
	 * @param bankBookDetailIdx
	 * @return
	 */
	public Map<String, Object> detail(Integer bankBookDetailIdx);
	
	/**
	 * 가계 상세 정보 등록 Service
	 * 
	 * @param bankBookDetailDTO
	 * @return
	 */
	public Map<String, Object> change(BankBookDetailDTO bankBookDetailDTO, String type);
}
