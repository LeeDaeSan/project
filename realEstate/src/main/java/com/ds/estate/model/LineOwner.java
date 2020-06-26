package com.ds.estate.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("lineOwner")
public class LineOwner {

	private Integer lineOwnerIdx;
	private Integer lineKindsIdx;
	private String ownerName;
	private String ownerLat;
	private String ownerLng;
	private Date createDate;
	
}
