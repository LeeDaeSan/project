package com.dm.sche.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.Board;

@Mapper
public interface BoardMapper {

	/**
	 * 
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 8.
	 * @Comment : 공통 게시판 리스트
	 *
	 */
	public List<Board> select(PagingDTO<Board> pagingDTO);
	
	
	public long selectForTotalcount(PagingDTO<Board> pagingDTO);
	
}
