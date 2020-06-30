package com.ds.homes.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.homes.model.Category;
import com.ds.homes.model.service.CategoryService;

@RestController
@RequestMapping("/rest/category")
public class CategoryRestController {

	@Autowired
	private CategoryService categoryService;
	
	/**
	 * Category 마지막 코드 조회 Controller
	 * 
	 * @param category
	 * @return
	 */
	@PostMapping("/code")
	public Map<String, Object> code (Category category) {
		return categoryService.selectLastCode(category);
	}
	
	/**
	 *  카테고리 저장 Controller
	 *  -> 등록, 수정, 삭제
	 * 
	 * @param category
	 * @param type
	 * @return
	 */
	@PostMapping("/change")
	public Map<String, Object> change (Category category, @RequestParam(value = "type") String type) {
		return categoryService.change(category, type);
	}
	
	/**
	 * 카테고리 목록 조회 Controller
	 * 
	 * @param category
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list (Category category) {
		return categoryService.select(category);
	}
	
	/**
	 * 카테고리 목록 조회 Controller
	 * 
	 * @param category
	 * @return
	 */
	@PostMapping("/detail")
	public Map<String, Object> detail (Category category) {
		return categoryService.detail(category);
	}
}
