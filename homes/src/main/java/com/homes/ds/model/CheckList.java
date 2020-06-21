package com.homes.ds.model;

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
@Alias("checkList")
public class CheckList {

	private Integer checkListIdx;
	private Integer checkMemoIdx;
	private String isChecked;
	private String title;
	private String content;
	private Date createDate;
	
	private CheckMemo checkMemo;
}
