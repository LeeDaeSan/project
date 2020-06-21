package com.homes.ds.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 가계 통장 유형 Table
 * 
 * @author idaesan
 *
 */
@Data
@Alias("bankBookType")
public class BankBookType {

	private Integer bankBookTypeIdx;
	private String typeName;
	private String typeCode;
	private String remark;
}
