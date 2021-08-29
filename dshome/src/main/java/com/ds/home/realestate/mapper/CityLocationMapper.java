package com.ds.home.realestate.mapper;

import java.util.List;

import com.ds.home.model.CityLocation;

public interface CityLocationMapper {

	public List<CityLocation> list(String depth, String cortarNo);
	
}
