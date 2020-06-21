package com.homes.ds.constant;

import org.springframework.security.core.context.SecurityContextHolder;

import com.homes.ds.security.SecurityUser;


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
