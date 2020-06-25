package com.ds.estate.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("lineKinds")
public class LineKinds {

	private Integer lineKinds;
	private String kindsName;
	private String kindsLat;
	private String kindsLng;
	private Date createDate;
	
}
