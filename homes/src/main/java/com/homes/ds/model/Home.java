package com.homes.ds.model;

import java.util.Date;

import lombok.Data;

@Data
public class Home {

	private Integer homeIdx;
	private String homeName;
	private String address;
	private Date createDate;
	
}
