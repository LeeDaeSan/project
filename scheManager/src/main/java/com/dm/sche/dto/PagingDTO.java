package com.dm.sche.dto;

import lombok.Data;

@Data
public class PagingDTO <T> {

	private Long totalCount;			// 페이지 총 카운트수
	private int page = 0;				// 현재 페이지
	private Long limit;					// limit
	
	private String sort;				// 정렬
	private String searchBoardName;		// 게시판 명 	[190816_KMJ]
	private String searchBoardType;		// 게시판 타입 	[190816_KMJ]
	
	private String searchIsUse;			// 사용 여부 
	private String searchDateType;		// 기간 유형
	private String searchStartDate;		// 기간 시작일
	private String searchEndDate;		// 기간 종료일
	private String searchKeyword;		// 검색 키워드		
	private String searchCodeType;		// 검색 코드 유형
	private String searchSelectType;	// 검색 셀렉트 유형

	private String periodType;			// 날짜 조회 타입
	
	private Integer boardIdx;
	private Integer memberIdx;
	private Integer parentIdx;
	
	private String level;
	
	private T model;

}
