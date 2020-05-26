package com.dm.sche.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.Board;

@Service
public interface BoardService {

	/**
	 * 
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 8.
	 * @Comment : 리스트 호출
	 *
	 */
	public Map<String, Object> select(PagingDTO<Board> pagingDTO);
	
	
}
