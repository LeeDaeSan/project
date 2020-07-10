package com.ds.homes.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("bankBookStatisticsDetail")
public class BankBookStatisticsDetail {

	private Integer statisticsDetailIdx;
	private Integer statisticsIdx;
	private Integer categoryIdx;
	private String amountType;
	private Double amount;
	
	private Category category1;
}
