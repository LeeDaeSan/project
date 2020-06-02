package com.homes.ds.model;

import java.util.Date;

import lombok.Data;

@Data
public class BankBookDetail {

	private Integer bankBookDetailIdx;
	private Integer bankBookIdx;
	private Integer homeIdx;
	private Integer category1Idx;
	private Integer category2Idx;
	private Integer category3Idx;
	private String content;
	private Double amount;
	private String type;
	private Date amountDate;
}
