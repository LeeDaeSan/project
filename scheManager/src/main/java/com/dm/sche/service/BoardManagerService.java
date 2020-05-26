package com.dm.sche.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.BoardManager;

@Service
public interface BoardManagerService {

	/**
	 * 
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 9.
	 * @Comment : 공통 게시판 리스트
	 *
	 */
	public Map<String, Object> select(PagingDTO<BoardManager> pagingDTO);
	
	/**
	 * 
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 12.
	 * @Comment : 공통 게시판 상세 조회
	 *
	 */
	public Map<String, Object> detail( int boardManagerIdx );
	
	/**
	 * 
	 * @param boardManagerIdx
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 11.
	 * @Comment : 공통 게시판 등록
	 */
	public Map<String, Object> merge(String type, BoardManager boardManager);
	
	/**
	 * 등록, 수정 시 중복 확인
	 * @param keywordDTO
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 12.
	 * @Comment : 
	 *
	 */
	public String keywordCheck(KeywordDTO keywordDTO);
	
}
