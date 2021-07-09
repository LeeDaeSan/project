package com.ds.home.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("member")
public class Member {
	
	private Integer memberIdx;
	private String memberId;
	private String password;
}
