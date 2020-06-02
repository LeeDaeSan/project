package com.homes.ds.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.homes.ds.model.Member;

@Mapper
public interface MemberMapper {

	/**
	 * Member 상세 조회 (로그인)
	 * @param id
	 * @return
	 */
	public Member getMember(String id);
	
}
