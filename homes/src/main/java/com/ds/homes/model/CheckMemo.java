package com.ds.homes.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 체크 목록 정보 Table
 * 
 * @author idaesan
 *
 */
@Data
@Alias("checkMemo")
public class CheckMemo {

	private Integer checkMemoIdx;
	private Integer homeIdx;
	private Integer bankIdx;
	private String isChecked;
	private String content;
	private Date createDate;
	private String accountNumber;
	private String accountHolder;
	private Double Amount;
	private String transferType;
	private String transferDate;
	private Bank bank;
	
	private CheckMemo checkMemo;
}
