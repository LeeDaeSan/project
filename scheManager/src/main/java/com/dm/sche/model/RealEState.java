package com.dm.sche.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 매물 정보
 * 
 * @author mijung
 */
@Data
@Alias("realEState")
public class RealEState {

	private Integer eStateIdx;				// 매물정보 PK
	private Integer areaIdx;				// 지역정보 PK
	private String name;					// 이름
	private String address;					// 주소
	private String dealType;				// 유형(1: 매매, 2: 월세, 3: 전세 ...)
	private String buildType;				// 건물유형(1: 아파트, 2: 빌라, 3: 주택, 4: 오피스텔 ...)
	private String remark;					// 비고
	private String interest;				// 관심도
	private String isImportant;				// 중요
	private Date createDate;				// 등록일
	
}
