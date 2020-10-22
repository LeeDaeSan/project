package com.ds.homes.model.dto;

import java.util.List;

import com.ds.homes.model.CheckMemo;

import lombok.Data;

@Data
public class CheckMemoDTO {

	private String type;
	
	private CheckMemo checkMemo;
	private List<CheckMemo> checkMemoList;
}
