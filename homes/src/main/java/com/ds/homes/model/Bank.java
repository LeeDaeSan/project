package com.ds.homes.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 은행 정보 Table
 * 
 * @author idaesan
 *
 */
@Data
@Alias("bank")
public class Bank {

	private Integer bankIdx;
	private String bankName;
	private String grade;
	private Date createDate;
	private Date updateDate;
}
