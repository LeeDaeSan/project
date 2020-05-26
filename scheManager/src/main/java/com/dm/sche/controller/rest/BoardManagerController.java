package com.dm.sche.controller.rest;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.Board;
import com.dm.sche.model.BoardManager;
import com.dm.sche.service.BoardManagerService;

@RestController
@RequestMapping("/boardManager")
public class BoardManagerController {

	private static final Logger logger = LoggerFactory.getLogger(BoardManagerController.class);
	
	@Autowired
	private BoardManagerService boardManagerService;
	
	/**
	 * 
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 12.
	 * @Comment : 공통 게시판 리스트
	 *
	 */
	@PostMapping("/list")
	public Map<String, Object> select(PagingDTO<BoardManager> pagingDTO){
		return boardManagerService.select(pagingDTO);
	}
	
	/**
	 * 
	 * @param boardManagerIdx
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 13.
	 * @Comment : 상세 정보 조회
	 *
	 */
	@PostMapping("/detail")
	public Map<String, Object> detail ( int boardManagerIdx ){
		return boardManagerService.detail(boardManagerIdx);
	}
	
	/**
	 * 
	 * @param keywordDTO
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 13.
	 * @Comment : 게시판명 중복 확인 
	 *
	 */
	@PostMapping("/nameChk")
	public String nameChk ( KeywordDTO keywordDTO ) {
		return boardManagerService.keywordCheck(keywordDTO);
		
	}
	
	/**
	 * 
	 * @param type
	 * @param boardManager
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 12.
	 * @Comment : 공통 게시판 등록, 수정, 삭제
	 *
	 */
	@PostMapping("/merge")
	@ResponseBody
	public Map<String, Object> merge(String type, BoardManager boardManager){
		return boardManagerService.merge(type, boardManager);
	}
}
