package com.dm.sche.service;

import java.util.Map;

import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.model.Member;

public interface MemberService {
	
	
	/**
	 * 
	 * @return
	 *
	 * @Author	: Moon JaeHwan
	 * @Date	: 2019. 8. 9.
	 * @Comment : 사용자 리스트
	 *
	 */
	public Map<String, Object> select();
	
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
	public Map<String, Object> detail(String id);
	
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
