package com.ds.homes.tools.constant;

import org.springframework.security.core.context.SecurityContextHolder;

import com.ds.homes.tools.security.SecurityUser;


public class UserConstant {

	/**
	 * 로그인 세션 정보
	 * 
	 * @return
	 * @throws Exception
	 */
	public static SecurityUser getUser () throws Exception {
		Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		try {
			return (SecurityUser)user;
		} catch (Exception e) {
			throw new Exception();
		}
	}
}
