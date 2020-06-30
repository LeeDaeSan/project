package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.BankBookDetail;
import com.ds.homes.model.dto.BankBookDetailDTO;
import com.ds.homes.model.dto.PagingDTO;

/**
 * 가계 상세 Mapper
 * 
 * @author idaesan
 */
@Mapper
public interface BankBookDetailMapper {

	/**
	 * 가계 상세 정보 목록 조회 Mapper
	 * 
	 * @param bankBookDetail
	 * @return
	 */
	public List<BankBookDetail> list(PagingDTO<BankBookDetail> pagingDTO);
	
	/**
	 * 가계 상세 정보 목록 total count Mapper
	 * 
	 * @param bankBookDetail
	 * @return
	 */
	public Long listForTotalCount(PagingDTO<BankBookDetail> pagingDTO);
	
	/**
	 * 가계 상세의 상세정보 조회 Mapper
	 * 
	 * @param bankBookDetailIdx
	 * @return
	 */
	public BankBookDetail detail(Integer bankBookDetailIdx);
	
	/**
	 * 가계 상세 정보 등록 Mapper
	 * 
	 * @param bankBookDetail
	 * @return
	 */
	public Integer insert(BankBookDetail bankBookDetail);

	/**
	 * 가계 상세 정보 수정 Mapper
	 * 
	 * @param bankBookDetail
	 * @return
	 */
	public Integer update(BankBookDetail bankBookDetail);
	
	/**
	 * 가계 상세 정보 삭제 Mapper
	 * 
	 * @param bankBookDetailDTO
	 * @return
	 */
	public Integer delete(BankBookDetailDTO bankBookDetailDTO);
	
	/**
	 * 통장 삭제시 통장의 상세정보 전체 삭제 Mapper
	 * 
	 * @param bankBookIdx
	 * @return
	 */
	public Integer deleteOfBankBook(Integer bankBookIdx);
}
