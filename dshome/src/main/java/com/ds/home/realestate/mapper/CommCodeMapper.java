package com.ds.home.realestate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ds.home.model.CommCode;

@Mapper
public interface CommCodeMapper {

	public List<CommCode> list(String type);
	
}
