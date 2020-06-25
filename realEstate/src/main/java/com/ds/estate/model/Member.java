package com.ds.estate.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member")
public class Member {

	private Integer memberIdx;
	private String memberName;
	private String memberId;
	private String password;
	private Date createDate;
	private Date updateDate;
	
}
