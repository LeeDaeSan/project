package com.ds.homes.model.dto;

import java.util.List;

import com.ds.homes.model.AccountBook;

import lombok.Data;

@Data
public class AccountBookDTO {

	private int accountBookIdx;
	
	private List<AccountBook> accountBookList;
}
