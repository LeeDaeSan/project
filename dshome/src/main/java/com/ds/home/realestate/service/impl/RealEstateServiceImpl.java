package com.ds.home.realestate.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.home.etc.constant.Constant;
import com.ds.home.etc.util.DateUtil;
import com.ds.home.etc.util.ResponseUtil;
import com.ds.home.model.Member;
import com.ds.home.model.MemberRealEstate;
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
	public Map<String, Object> select(MemberRealEstate memberRealEstate) {
		
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			// 목록 조회
			resultMap.put("list", memberRealEstateMapper.select(memberRealEstate));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> merge(String type, MemberRealEstate memberRealEstate) {
		
		Map<String, Object> resultMap = null;
		
		try {
			
			Member member = new Member();
			member.setMemberIdx(1);
			memberRealEstate.setUseApproveDate(DateUtil.stringToDate(memberRealEstate.getUseApproveDateStr(), "yyyyMMdd"));
			if (type.equals(Constant.MERGE_TYPE_INSERT)) {
				memberRealEstateMapper.insert(type, memberRealEstate, member.getMemberIdx());
			}
			
			// else
			
			resultMap = ResponseUtil.successMap();
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
}
