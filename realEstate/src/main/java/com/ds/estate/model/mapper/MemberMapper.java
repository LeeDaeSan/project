package com.ds.estate.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ds.estate.model.Member;

@Mapper
public interface MemberMapper {

	/**
	 * 사용자 로그인 정보 조회 Mapper
	 * 
	 * @param id
	 * @return
	 */
	public Member getMember(String id);
}
