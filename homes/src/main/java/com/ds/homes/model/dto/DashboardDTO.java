package com.ds.homes.model.dto;

import lombok.Data;

@Data
public class DashboardDTO {

	private String amountType;
	private Integer category1Idx;
	private String categoryName;
	private Double totalAmount;
	
	private Double inTotalAmount;
	private Double outTotalAmount;
	private Double otherTotalAmount;
}
