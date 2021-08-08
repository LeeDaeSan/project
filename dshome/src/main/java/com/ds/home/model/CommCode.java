package com.ds.home.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("commCode")
public class CommCode {

	private Integer commCodeIdx;
	private String code;
	private String name;
	private String type;
	private Date createDate;
	private Date updateDate;
	
}
