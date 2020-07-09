package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.BankBookDetail;
/**
 * 가계 정산 Mapper
 * 
 * @author idaesan
 *
 */
@Mapper
public interface CalculateMapper {

	/**
	 * 현재월 기준 정산 목록 조회
	 * 
	 * @param homeIdx
	 * @return
	 */
	public List<BankBookDetail> select(BankBookDetail bankBookDetail);
	
}
