package com.ds.home.realestate.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.home.realestate.service.CityLocationService;

@RestController
@RequestMapping("/rest/cityLocation")
public class CityLocationController {

	private static final Logger logger = LoggerFactory.getLogger(CityLocationController.class);
	
	@Autowired
	private CityLocationService cityLocationService;
	
	
	@GetMapping("/list")
	public Map<String, Object> listForCityLocation(@RequestParam("depth") String depth, @RequestParam("cortarNo") String cortarNo){
		return cityLocationService.list(depth, cortarNo);
	}
	
	
	
}
