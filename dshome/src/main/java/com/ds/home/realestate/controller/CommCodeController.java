package com.ds.home.realestate.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ds.home.realestate.service.CommCodeService;


@RestController
@RequestMapping("/comm/code")
public class CommCodeController {

	private static final Logger logger = LoggerFactory.getLogger(CommCodeController.class);
	
	@Autowired
	private CommCodeService commCodeService;
	
	@GetMapping("/list")
	public Map<String, Object> list(@RequestParam("type") String type){
		return commCodeService.list(type);
	}
	
}
