package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.AccountCategory;

/**
 * AccountCategory Mapper
 * 
 * @author idaesan
 *
 */
@Mapper
public interface AccountCategoryMapper {

	/**
	 * 목록 조회 Mapper
	 * 
	 * @param accountCategory
	 * @return
	 */
	public List<AccountCategory> list(AccountCategory accountCategory);
	
	/**
	 * 가계부에서 조회할 목록 Mapper
	 * 
	 * @param accountCategory
	 * @return
	 */
	public List<AccountCategory> listOfAccountBook(AccountCategory accountCategory);
	
	/**
	 * 등록 Mapper
	 * 
	 * @param accountCategory
	 * @return
	 */
	public Integer insert(AccountCategory accountCategory);
}
