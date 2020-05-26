package com.dm.sche.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.mapper.MemberMapper;
import com.dm.sche.model.Member;
import com.dm.sche.service.MemberService;
import com.dm.sche.util.ResponseUtil;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	

	/**
	 * 사용자 리스트
	 */
	@Override
	public Map<String, Object> select() {
		
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", memberMapper.select());
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	/**
	 * 사용자 상세 정보
	 */
	@Override
	public Map<String, Object> detail (String id) {
		
		Map<String, Object> resultMap = null;
	      
		try {
			
			resultMap = ResponseUtil.successMap();
	        resultMap.put("detail", memberMapper.detail(id));
	         
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}

		return resultMap;
		
	}
	
	/**
	 * 사용자 등록
	 */
	@Override
	public void insert(Member member) {
		memberMapper.insert(member);
	}
	
	/**
	 * 아이디 중복 확인
	 */
	@Override
	public String selectForId(KeywordDTO keywordDTO) {
		return memberMapper.selectForId(keywordDTO);
	}

	/**
	 * 사용자 정보 수정
	 */
	@Override
	public void update(Member member) {
		memberMapper.update(member);
		
	}

	
}
