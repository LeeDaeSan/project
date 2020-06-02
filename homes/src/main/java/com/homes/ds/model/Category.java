package com.homes.ds.model;

import java.util.Date;

import lombok.Data;

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
