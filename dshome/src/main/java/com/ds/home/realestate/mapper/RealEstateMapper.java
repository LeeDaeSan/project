package com.ds.home.realestate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.home.model.CityLocation;

@Mapper
public interface RealEstateMapper {

	public List<CityLocation> getCityLocationList(String cortarNo, String depth);

}
