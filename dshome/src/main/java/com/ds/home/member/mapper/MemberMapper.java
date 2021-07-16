package com.ds.home.member.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ds.home.model.Member;

/**
 * 사용자 정보 Mapper
 * 
 * @author daesan
 *
 */
@Mapper
public interface MemberMapper {

	/**
	 * 사용자 정보 조회
	 * 
	 * @param member
	 * @return
	 */
	public Member getMember(String memberId);
}
