package com.dm.sche.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("keywordDTO")
public class KeywordDTO {

	private String keywordType;
	private String keyword;
	
	private Integer memberIdx;
	private String level;
	
}
