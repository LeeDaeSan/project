package com.ds.home.realestate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.home.model.StationInfo;

@Mapper
public interface StationInfoMapper {

	public List<StationInfo> list();

	public List<StationInfo> detail(String stationLineNo);
	
}
