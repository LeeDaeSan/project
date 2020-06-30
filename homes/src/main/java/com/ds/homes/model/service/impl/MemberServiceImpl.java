package com.ds.homes.model.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.mapper.MemberMapper;
import com.ds.homes.model.service.MemberService;
import com.ds.homes.tools.util.ResponseUtil;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	/**
	 * 사용자 상세 정보 조회
	 */
	@Override
	public Map<String, Object> getMember(String id) {
		
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("detail", memberMapper.getMember(id));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap(); 
		}
		
		return resultMap;
	}
}
