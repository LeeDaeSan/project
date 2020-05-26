package com.dm.sche.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 일정관리 상세 정보
 * @author idaesan
 *
 */
@Data
@Alias("scheduleDetail")
public class ScheduleDetail {
	
	private Integer scheduleIdx;				// 일정 PK
	private String scheduleName;				// 일정 명
	private String scheduleComment;				// 일정 상세 설명
	private Date scheduleStartDate;				// 일정 시작일
	private Date scheduleEndDate;				// 일정 종료일
	private String isUse;						// 사용 여부
	private String color;						// 색상
	private String place;						// 장소
	private String link;						// 링크
	private Date createDate;					// 생성일
	private Date updateDate;					// 수정일
	
	private Schedule schedule;					// 일정 관리

	
}
