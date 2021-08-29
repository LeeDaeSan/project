package com.ds.home.realestate.service;

import java.util.Map;

public interface StationInfoService {

	public Map<String, Object> list();

	public Map<String, Object> detail(String stationLineNo);
	
}
