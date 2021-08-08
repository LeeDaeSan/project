package com.ds.home.realestate.service;

import java.util.Map;

import org.springframework.stereotype.Service;

public interface CommCodeService {

	// 공통 코드 리스트
	public Map<String, Object> list(String type);
	
}
