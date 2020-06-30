package com.ds.homes.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 통장 정보 Table
 * 
 * @author idaesan
 *
 */
@Data
@Alias("bankBook")
public class BankBook {

	private Integer bankBookIdx;
	private Integer memberIdx;
	private Integer homeIdx;
	private Integer bankIdx;
	private Integer bankBookTypeIdx;
	private String bankBookName;
	private String acountNumber;
	private Double totalAmount;
	private Date openDate;
	private Date closeDate;
	private Date createDate;
	private Date updateDate;
	
	private String openDateStr;
	private String closeDateStr;
	
	private Member member;
	private Bank bank;
	private BankBookType bankBookType;
}
