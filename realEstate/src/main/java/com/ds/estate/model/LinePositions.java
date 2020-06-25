package com.ds.estate.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("linePositions")
public class LinePositions {

	private Integer linePositionsIdx;
	private Integer lineKindsIdx;
	private String linePositionName;
	private String linePositionLat;
	private String linePositionLng;
	private Date CreateDate;
	
}
