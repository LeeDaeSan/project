package com.homes.ds.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.homes.ds.model.Bank;

@Mapper
public interface BankMapper {

	/**
	 * 은행 목록 조회
	 * 
	 * @return
	 */
	public List<Bank> list();
}
