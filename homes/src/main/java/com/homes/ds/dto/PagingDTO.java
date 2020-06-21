package com.homes.ds.dto;

import java.util.List;

import lombok.Data;

@Data
public class PagingDTO <T> {

	private Long totalCount;
	private Integer page = 0;
	private Long limit;
	
	private String sort;
	private String sortType;
	
	private Boolean allChecked;
	private List<String> checkedList;
	
	private String startDateStr1;
	private String endDateStr1;
	private String startDateStr2;
	private String endDateStr2;
	
	private Double startAmount;
	private Double endAmount;
	
	private T model;
}
