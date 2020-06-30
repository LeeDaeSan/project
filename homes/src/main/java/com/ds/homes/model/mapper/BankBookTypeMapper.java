package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.BankBookType;

/**
 * 통장 유형 정보 Mapper
 * 
 * @author idaesan
 *
 */
@Mapper
public interface BankBookTypeMapper {

	/**
	 * 통장 유형 목록 조회 Mapper
	 * 
	 * @return
	 */
	public List<BankBookType> select();
}
