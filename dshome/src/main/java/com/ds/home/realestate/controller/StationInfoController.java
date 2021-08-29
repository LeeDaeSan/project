package com.ds.home.realestate.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.home.realestate.service.StationInfoService;

@RestController
@RequestMapping("/rest/stationInfo/")
public class StationInfoController {

	@Autowired
	private StationInfoService stationInfoService;
	
	@RequestMapping("/list")
	public Map<String, Object> list (){
		return stationInfoService.list();
	}
	
	@RequestMapping("/detail")
	public Map<String, Object> detail(@RequestParam("stationLineNo") String stationLineNo){
		return stationInfoService.detail(stationLineNo);
	}
	
}
