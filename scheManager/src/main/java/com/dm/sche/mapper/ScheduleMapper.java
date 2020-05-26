package com.dm.sche.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.dm.sche.model.Schedule;

@Mapper
public interface ScheduleMapper {

	/**
	 * 일정 등록
	 * @param schedule
	 * @return
	 */
	public Integer insert(Schedule schedule);
}
