package com.homes.ds.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.homes.ds.model.BankBook;

@Mapper
public interface BankBookMapper {

	/**
	 * 가계부 목록 조회
	 * 
	 * @param bankBook
	 */
	public List<BankBook> list (BankBook bankBook);
}
