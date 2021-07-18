package com.ds.home.realestate.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.home.etc.util.ResponseUtil;
import com.ds.home.model.MemberRealEstate;
import com.ds.home.model.dto.PagingDTO;
import com.ds.home.realestate.mapper.MemberRealEstateMapper;
import com.ds.home.realestate.service.RealEstateService;

/**
 * 사용자 부동산 정보 Service Implements
 * 
 * @author daesan
 *
 */
@Service
public class RealEstateServiceImpl implements RealEstateService {
	
	/**
	 * 사용자 부동산 정보 Mapper
	 */
	@Autowired
	private MemberRealEstateMapper memberRealEstateMapper;
	

	/**
	 * 사용자 부동산 정보 목록 조회
	 * 
	 */
	@Override
	public Map<String, Object> select(PagingDTO<MemberRealEstate> pagingDTO) {
		
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			// 목록 조회
			resultMap.put("list", memberRealEstateMapper.select(pagingDTO));
			// total count
			resultMap.put("totalCount", memberRealEstateMapper.selectOfTotalCount(pagingDTO));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			System.out.println(e);
		}
		
		return resultMap;
	}
}
