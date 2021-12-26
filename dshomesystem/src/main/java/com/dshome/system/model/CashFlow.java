package com.dshome.system.model;

import java.util.Date;

import lombok.Data;

/**
 * 현금흐름표 Table
 * 
 * @author daesan
 *
 */
@Data
public class CashFlow {

	private Integer cashFlowIdx;
	private Integer memberIdx;
	private String flowType;
	private Date flowDate;
	private String category1;
	private String category2;
	private String category3;
	private Long price;
	private Date createDate;
	private Date updateDate;
	
	private String flowDateStr;
}
