package com.ds.homes.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.Member;

@Mapper
public interface MemberMapper {

	/**
	 * Member 상세 조회 (로그인)
	 * @param id
	 * @return
	 */
	public Member getMember(String id);
	
}
