package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.AccountBook;
import com.ds.homes.model.dto.PagingDTO;

/**
 * 가계부 Mapper
 * 
 * @author idaesan
 *
 */
@Mapper
public interface AccountBookMapper {

	/**
	 * 가계부 목록 조회 Mapper
	 * 
	 * @param pagingDTO
	 * @return
	 */
	public List<AccountBook> select(PagingDTO<AccountBook> pagingDTO);
	
	/**
	 * 가계부 등록 Mapper
	 * 
	 * @param accountBook
	 * @return
	 */
	public Integer insert(AccountBook accountBook);
	
	/**
	 * 가계부 삭제 Mapper
	 * 
	 * @param accountBookIdx
	 * @return
	 */
	public Integer delete(int accountBookIdx);
}
