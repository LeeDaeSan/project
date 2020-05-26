package com.dm.sche.model;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 지역 정보
 * @author idaesan
 *
 */
@Data
@Alias("areaInfo")
public class AreaInfo {

	private Integer areaIdx;		// 지역정보 PK
	private Integer memberIdx;		// 사용자 PK
	private String areaName;		// 지역명
	private String areaCode;		// 지역코드
	private Double lat;				// 위도
	private Double lng;				// 경도
	private Date createDate;		// 생성일
	
	private Member member;			// 사용자 정보
	
	private List<AreaInfoDetails> areaInfoDetails;
}
