package com.ds.homes.model.dto;

import com.ds.homes.model.BankBookStatisticsDetail;

import lombok.Data;

@Data
public class BankBookStatisticsDetailDTO extends BankBookStatisticsDetail {

	private Integer homeIdx;
	private String amountDateStr;
}
