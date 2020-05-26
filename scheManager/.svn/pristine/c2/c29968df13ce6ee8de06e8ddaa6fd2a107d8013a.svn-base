package com.dm.sche.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.model.Member;

@Mapper
public interface MemberMapper {

	
	/**
	 * 
	 * @return
	 *
	 * @Author	: Moon JaeHwan
	 * @Date	: 2019. 8. 9.
	 * @Comment : 사용자 리스트
	 *
	 */
	public List<Member> select();
	
	/**
	 * 
	 * @param id
	 * @return
	 *
	 * @Author	: Moon JaeHwan
	 * @Date	: 2019. 8. 9.
	 * @Comment : 사용자 상세 정보
	 *
	 */
	public Member detail(String id);
	
	/**
	 * 
	 * @param member
	 *
	 * @Author	: Moon JaeHwan
	 * @Date	: 2019. 8. 9.
	 * @Comment : 사용자 등록
	 *
	 */
	public void insert(Member member);

	/**
	 * 
	 * @param keywordDTO
	 * @return
	 *
	 * @Author	: Moon JaeHwan
	 * @Date	: 2019. 8. 9.
	 * @Comment : 아이디 중복 확인
	 *
	 */
	public String selectForId(KeywordDTO keywordDTO);
	
	/**
	 * 
	 * @param member
	 *
	 * @Author	: Moon JaeHwan
	 * @Date	: 2019. 8. 9.
	 * @Comment : 사용자 정보 수정
	 *
	 */
	public void update(Member member);

	
}
