package com.homes.ds.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("bankBook")
public class BankBook {

	private Integer bankBookIdx;
	private Integer memberIdx;
	private Integer homeIdx;
	private Integer bankIdx;
	private String bankBookName;
	private Date openDate;
	private Date createDate;
	private Date updateDate;
}
