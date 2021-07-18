package com.ds.home.realestate.service;

import java.util.Map;

import com.ds.home.model.MemberRealEstate;
import com.ds.home.model.dto.PagingDTO;

/**
 * 사용자 부동산 정보 Service
 * @author daesan
 *
 */
public interface RealEstateService {

	
	/**
	 * 사용자 부동산 정보 목록 조회
	 * 
	 * @param memberRealEstate
	 * @return
	 */
	public Map<String, Object> select(PagingDTO<MemberRealEstate> pagingDTO);
	
}
