package com.dm.sche.model;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 일정관리
 * @author idaesan
 *
 */
@Data
@Alias("schedule")
public class Schedule {

	private Integer scheduleIdx;					// PK
	private Integer memberIdx;						// 사용자 PK
	private Integer subMenuIdx;						// 하위메뉴 PK
	private Date createDate;						// 생성일
	private Date updateDate;						// 수정일
	
	private Member member;							// 개인정보
	private SubMenu subMenu;						// 하위메뉴 정보
	
	private List<ScheduleDetail> scheduleDetail;	// 하위메뉴 목록
}
