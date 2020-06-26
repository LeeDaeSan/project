package com.ds.estate.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.estate.model.LineOwner;

/**
 * 라인정보 Mapper
 * 
 * @author idaesan
 *
 */
@Mapper
public interface LineOwnerMapper {

	/**
	 * 라인정보 목록 조회
	 * 
	 * @return
	 */
	public List<LineOwner> list();
	
	/**
	 * 라인정보 등록
	 * 
	 * @param lineOwner
	 * @return
	 */
	public Integer insert(LineOwner lineOwner);
}
