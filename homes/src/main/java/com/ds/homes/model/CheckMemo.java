package com.ds.homes.model;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 체크 메모 정보 Table
 * 
 * @author idaesan
 *
 */
@Data
@Alias("checkMemo")
public class CheckMemo {

	private Integer checkMemoIdx;
	private Integer homeIdx;
	private String memo;
	
	private List<CheckList> checkList;
}
