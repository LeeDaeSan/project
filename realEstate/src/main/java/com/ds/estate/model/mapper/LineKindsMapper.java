package com.ds.estate.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.estate.model.LineKinds;

/**
 * 라인 유형 정보 Mapper
 * 
 * @author idaesan
 *
 */
@Mapper
public interface LineKindsMapper {

	/**
	 * 라인 유형 정보 목록 조회
	 * 
	 * @return
	 */
	public List<LineKinds> list();
	
}
