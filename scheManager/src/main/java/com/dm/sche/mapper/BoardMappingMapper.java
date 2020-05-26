package com.dm.sche.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.dm.sche.model.BoardMapping;

@Mapper
public interface BoardMappingMapper {

	/**
	 * 게시판 맵핑 등록
	 * 
	 * @param boardMapping
	 * @return
	 */
	public Integer insert(BoardMapping boardMapping);
}
