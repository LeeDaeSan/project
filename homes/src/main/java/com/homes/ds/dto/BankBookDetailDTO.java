package com.homes.ds.dto;

import java.util.List;

import com.homes.ds.model.BankBookDetail;

import lombok.Data;

@Data
public class BankBookDetailDTO {

	private BankBookDetail befBankBookDetail;
	private BankBookDetail aftBankBookDetail;
	
	private List<Integer> deleteList;
	
	private List<BankBookDetail> bankBookDetailList;
}
