package com.ds.homes.model.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.Category;
import com.ds.homes.model.mapper.CategoryMapper;
import com.ds.homes.model.service.CategoryService;
import com.ds.homes.tools.constant.Constant;
import com.ds.homes.tools.util.ResponseUtil;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	private CategoryMapper categoryMapper;

	/**
	 * 마지막 코드 정보 조회
	 */
	@Override
	public Map<String, Object> selectLastCode(Category category) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("code", categoryMapper.selectLastCode(category));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			log.error("{}", e);
		}
		
		return resultMap;
	}

	/**
	 * 카테고리 저장
	 *  -> 등록, 수정, 삭제
	 */
	@Override
	public Map<String, Object> change(Category category, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			Integer result = 0;
			
			// 등록
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				result = categoryMapper.insert(category);
			}
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("result", result);
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	/**
	 * 카테고리 목록 조회
	 */
	@Override
	public Map<String, Object> select(Category category) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", categoryMapper.select(category));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			log.error("{}", e);
		}
		
		return resultMap;
	}
	
	/**
	 * 카테고리 상세 조회
	 */
	@Override
	public Map<String, Object> detail(Category category) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("detail", categoryMapper.detail(category));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			log.error("{}", e);
		}
		
		return resultMap;
	}
}
