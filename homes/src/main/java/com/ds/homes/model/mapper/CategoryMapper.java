package com.ds.homes.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.homes.model.Category;

@Mapper
public interface CategoryMapper {

	/**
	 * 마지막 코드 정보 조회
	 * 
	 * @param category
	 * @return
	 */
	public String selectLastCode(Category category);
	
	/**
	 * 카테고리 정보 등록
	 * 
	 * @param category
	 * @return
	 */
	public Integer insert(Category category);
	
	/**
	 * 카테고리 목록 조회
	 * 
	 * @param category
	 * @return
	 */
	public List<Category> select(Category category);
	
	/**
	 * 카테고리 상세 조회
	 * @param category
	 * @return
	 */
	public Category detail(Category category);
}
