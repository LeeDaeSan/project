package com.dm.sche.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 가계부 품목 상세 정보
 * @author idaesan
 *
 */
@Data
@Alias("houseHoldItemDetail")
public class HouseHoldItemDetail {

	private Integer itemDetailIdx;			// 상세 품목 PK
	private Integer itemIdx;				// 대분류 품목 PK
	private String itemDetailName;			// 상세 품목명
	private String itemDetailCode;			// 상세 품목코드
	private Integer createMemberIdx;		// 생성자 PK
	private Integer updateMemberIdx;		// 수정자 PK
	private Date createDate;				// 생성일
	private Date updateDate;				// 수정일
}
