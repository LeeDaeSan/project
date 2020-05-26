package com.dm.sche.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("memberHoldItem")
public class MemberHoldItem {

	private Integer memberHoldItemIdx;
	private Integer memberIdx;
	private Integer item1Idx;
	private Integer item2Idx;
	private Integer item3Idx;
	private Double amount;
	private String type;
	private String remark;
	private Date holdDate;
	private Date createDate;
	
	private Member member;
	
	// 대분류 코드
	private HouseHoldItem houseHoldItem;
	// 중분류 코드
	private HouseHoldItem2 houseHoldItem2;
	// 소분류 코드
	private HouseHoldItem3 houseHoldItem3;
	
	private FontColor fontColor;
}
