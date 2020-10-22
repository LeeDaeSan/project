package com.ds.homes.model;

import java.util.Date;

import lombok.Data;

@Data
public class AccountBook {
	private Integer accountBookIdx;
	private Integer homeIdx;
	private Integer category1Idx;
	private Integer category2Idx;
	private Integer category3Idx;
	private Integer category4Idx;
	private Integer category5Idx;
	private String content;
	private Double amount;
	private Date accountDate;
	private Date createDate;
	
	private String accountDateStr;
	
	private AccountCategory accountCategory1;
	private AccountCategory accountCategory2;
	private AccountCategory accountCategory3;
	private AccountCategory accountCategory4;
	private AccountCategory accountCategory5;
	
	private String amountDateStr;
	
	private Double totalAmount1;
	private Double totalAmount2;
	
	
}
