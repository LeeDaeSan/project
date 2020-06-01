package com.homes.ds.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.homes.ds.constant.Constant;

@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		System.out.println();
		// 로그인 disabled 처리 : (에러로 인해 csrf 임시 막기)
		http.cors().and();
		http.csrf().disable();
		
		// 접근권한 설정
		http.authorizeRequests()
			.antMatchers("/login").permitAll()
			.anyRequest().authenticated();
		
		// 로그인 설정
		http.formLogin()
			.loginPage("/" + Constant.VIEWS + "/login")
			.permitAll();
	}
}
