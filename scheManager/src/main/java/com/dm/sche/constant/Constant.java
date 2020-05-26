package com.dm.sche.constant;

public class Constant {

	//view default path
	public static final String VIEWS 	= "views";
	public static final String NOTILES 	= "notiles";
	
	public static final String MAIN_MENU_URL_PATTERN = VIEWS;
	
	/**
	 * Merge Type
	 */
	public static final String MERGE_TYPE_INSERT = "I";		// 등록
	public static final String MERGE_TYPE_UPDATE = "U";		// 수정
	public static final String MERGE_TYPE_DELETE = "D";		// 삭제
	
	/**
	 * 대메뉴 PK
	 */
	public static final int MAIN_MENU_HOUSEHOLD_IDX = 1;	// 가계부
	public static final int MAIN_MENU_SCHEDULE_IDX	= 2;	// 일정
	public static final int MAIN_MENU_MANAGER_IDX	= 4;	// 관리
	public static final int MAIN_MENU_ESTATE_IDX	= 5;	// 부동산
	public static final int MAIN_MENU_BOARD_IDX		= 6;	// 공지 & 게시
	
	/**
	 * 사용여부 IsUse
	 * 
	 */
	public static final String ISUSE_TYPE_Y = "Y";
	public static final String ISUSE_TYPE_N = "N";
	
	/**
	 * 가계부 입금 유형
	 */
	public static final String HOLD_ITEM_TYPE_IN 	= "I";	// 입금
	public static final String HOLD_ITEM_TYPE_OUT 	= "O";	// 출금
	
	/**
	 * 하위메뉴 경로
	 */
	public static final String MENU_BOARD_URL 		= "board/list?idx=";	// 공지 & 게시 메뉴 공통 경로
	public static final String MENU_SCHEDULE_URL 	= "schedule/list?idx=";	// 일정관리 메뉴 공통 경로
}
