package com.ds.home.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("stationInfo")
public class StationInfo {

	private Integer stationIdx;
	private String stationNo;
	private String stationName;
	private String stationLineNo;
	private String stationLineName;
	private String latitude;
	private String longitude;
	private String address;
	
}
