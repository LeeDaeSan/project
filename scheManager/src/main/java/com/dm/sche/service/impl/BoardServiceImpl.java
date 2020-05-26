package com.dm.sche.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dm.sche.dto.PagingDTO;
import com.dm.sche.mapper.BoardMapper;
import com.dm.sche.model.Board;
import com.dm.sche.service.BoardService;
import com.dm.sche.util.ResponseUtil;

@Service
public class BoardServiceImpl implements BoardService {

	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);
	
	@Autowired
	private BoardMapper boardMapper;
	
	/**
	 * 공통 게시판 리스트
	 */
	@Override
	public Map<String, Object> select(PagingDTO<Board> pagingDTO) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			
			resultMap = ResponseUtil.successMap();

			resultMap.put("list", boardMapper.select(pagingDTO));
			resultMap.put("totalcount", boardMapper.selectForTotalcount(pagingDTO));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	
}
