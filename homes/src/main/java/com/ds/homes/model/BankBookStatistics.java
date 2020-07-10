package com.ds.homes.model;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("bankBookStatistics")
public class BankBookStatistics {

	private Integer statisticsIdx;
	private Integer homeIdx;
	private Date statisticsDate;
	private String statisticsRealDate;
	private Double incomeAmount;
	private Double spendingAmount;
	private Double remainingAmount;
	private Date createDate;
	
	private String staticticsDateStr;
	
	private List<BankBookStatisticsDetail> bankBookStatisticsDetailList;
	
}
