package com.ds.homes.model;

import java.util.Date;

import lombok.Data;

@Data
public class AccountCategory {

	private Integer categoryIdx;
	private String categoryName;
	private Integer level;
	private Integer orderLevel;
	private Integer parentIdx;
	private Date createDate;
}
