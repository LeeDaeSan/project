package com.dm.sche.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 지역 정보 상세 
 * @author idaesan
 *
 */
@Data
@Alias("areaInfoDetails")
public class AreaInfoDetails {

	private Integer areaInfoDetailsIdx;		// 지역정보 상세 PK
	private Integer areaInfoIdx;			// 지역정보 PK
	private Integer monthlyPrice;			// 월세 가격
	private Integer housingPrice;			// 전세 가격
	private Integer buyingPrice;			// 매매 가격
	private Date createDate;				// 생성일
	
	private AreaInfo areaInfo;				// 지역정보
	
}
