package com.homes.ds.model;

import java.util.Date;

import lombok.Data;

@Data
public class Member {
	
	private Integer memberIdx;
	private Integer homeIdx;
	private String memberName;
	private String memberId;
	private String password;
	private Date createDate;
	private Date updateDate;
}
