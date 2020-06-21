package com.homes.ds.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 통장 상세 정보 Table
 * 
 * @author idaesan
 *
 */
@Data
@Alias("bankBookDetail")
public class BankBookDetail {

	private Integer bankBookDetailIdx;
	private Integer bankBookIdx;
	private Integer homeIdx;
	private Integer category1Idx;
	private Integer category2Idx;
	private Integer category3Idx;
	private String content;
	private Double amount;
	private String amountType;
	private Date amountDate;
	
	private String amountDateStr;
	
	private Category category1;
	private Category category2;
	private Category category3;
	
}
