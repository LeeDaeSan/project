package com.dm.sche.controller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dm.sche.model.Member;
import com.dm.sche.service.MemberService;


@RestController
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	/**
	 * 
	 * @return
	 *
	 * @Author	: Moon JaeHwan
	 * @Date	: 2019. 8. 9.
	 * @Comment : 사용자 리스트
	 *
	 */
	@PostMapping(value = "/list")
	public Map<String, Object> list () {
		return memberService.select();
	}
	
	/**
	 * 
	 * @param id
	 * @return
	 *
	 * @Author	: Moon JaeHwan
	 * @Date	: 2019. 8. 9.
	 * @Comment : 사용자 상세 정보
	 *
	 */
	@PostMapping(value = "/detail")
	public Map<String, Object> detail (@RequestParam(value = "id", required = true) String id) {
		return memberService.detail(id);
	}
}
