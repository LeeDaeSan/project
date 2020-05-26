package com.dm.sche.controller.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.model.Member;
import com.dm.sche.service.MemberService;

@Controller
@RequestMapping("/join")
public class JoinController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String Join(Member member) {
		
		memberService.insert(member);
			
		return "/login";
	}
	
	@ResponseBody
	@PostMapping(value = "/getId")
	public String selectForId(KeywordDTO keywordDTO) {
		return memberService.selectForId(keywordDTO);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public void Update(Member member) {
		memberService.update(member);
	}
	
}
