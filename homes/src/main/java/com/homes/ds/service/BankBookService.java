package com.homes.ds.service;

import java.util.Map;

import com.homes.ds.model.BankBook;

public interface BankBookService {

	/**
	 * 가계부 목록 조회
	 * 
	 * @return
	 */
	public Map<String, Object> list(BankBook bankBook);
}
