package com.ds.home.realestate.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.home.model.CityLocation;
import com.ds.home.realestate.mapper.RealEstateMapper;
import com.ds.home.realestate.service.RealEstateService;

@Service
public class RealEstateServiceImpl implements RealEstateService {
	
	@Autowired
	private RealEstateMapper realEstateMapper;
	
	@Override
	public List<CityLocation> getCityLocationList(String cortarNo, String depth) {
		
		List<CityLocation> cityLocationList = realEstateMapper.getCityLocationList(cortarNo, depth);

		return cityLocationList;
	}

}
