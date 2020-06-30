package com.ds.homes.model;

import java.util.Date;

import lombok.Data;

/**
 * Home Table
 * 
 * @author idaesan
 *
 */
@Data
public class Home {

	private Integer homeIdx;
	private String homeName;
	private String address;
	private Date createDate;
	
}
