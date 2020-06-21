package com.homes.ds.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 사용자 정보 Table
 * 
 * @author idaesan
 *
 */
@Data
@Alias("member")
public class Member {
	
	private Integer memberIdx;
	private Integer homeIdx;
	private String memberName;
	private String memberId;
	private String password;
	private Date createDate;
	private Date updateDate;
}
