package com.ds.home.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("cityLocation")
@Data
public class CityLocation {

	private Integer idx;					// INDEX
	private String cortarNo;				// 주소지 코드
	private String cortarName;				// 주소지 명
	private String centerLat;				// 위도
	private String centerLon;				// 경도
	private String parentCortarNo;			// 부모 주소지 코드
	private String depth;					// depth (시/도: 0, 구/군: 1, 동: 2)
	
}
