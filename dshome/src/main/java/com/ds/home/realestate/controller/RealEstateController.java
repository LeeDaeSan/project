package com.ds.home.realestate.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ds.home.model.CityLocation;
import com.ds.home.realestate.service.RealEstateService;

@Controller
@RequestMapping("/city")
public class RealEstateController {
	
	private static final Logger logger = LoggerFactory.getLogger(RealEstateController.class);
	
	@Autowired
	private RealEstateService realEstateService;
	
	@GetMapping("/list")
	@ResponseBody
	public List<CityLocation> getCityLocationList(CityLocation cityLocation){
		return realEstateService.getCityLocationList(cityLocation.getCortarNo(), cityLocation.getDepth());
	}

}
