package com.ds.homes.model;

import java.util.Date;

import lombok.Data;

/**
 * 분류 정보 Table
 * 
 * @author idaesan
 *
 */
@Data
public class Category {

	private Integer categoryIdx;
	private String categoryName;
	private String categoryCode;
	private Integer level;
	private Integer parentIdx;
	private Date createDate;
	private Date updateDate;
	
}
