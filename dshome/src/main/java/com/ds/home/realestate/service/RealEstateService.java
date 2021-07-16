package com.ds.home.realestate.service;

import java.util.List;

import com.ds.home.model.CityLocation;

public interface RealEstateService {

	public List<CityLocation> getCityLocationList(String cortarNo, String depth);
	
}
