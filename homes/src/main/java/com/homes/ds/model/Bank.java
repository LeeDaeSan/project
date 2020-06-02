package com.homes.ds.model;

import java.util.Date;

import lombok.Data;

@Data
public class Bank {

	private Integer bankIdx;
	private String homeName;
	private String grade;
	private Date createDate;
	private Date updateDate;
}
