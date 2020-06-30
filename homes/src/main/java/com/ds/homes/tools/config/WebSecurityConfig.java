package com.ds.homes.tools.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.ds.homes.tools.constant.Constant;
import com.ds.homes.tools.security.CustomUserDetailsService;

@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private CustomUserDetailsService customUserDetailsService;
	
	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;
	
	@Autowired
	private AuthenticationFailureHandler authenticationFailureHandler;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserDetailsService).passwordEncoder(new BCryptPasswordEncoder());
	}
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers(
							"/img/**",
							"/lib/**",
							"/css/**",
							"/js/**",
							"/webjars/**");
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// 로그인 disabled 처리 : (에러로 인해 csrf 임시 막기)
		http.cors().and();
		http.csrf().disable();
		
		// 접근권한 설정
		http.authorizeRequests()
			.antMatchers("/login").permitAll()
			.anyRequest().authenticated();
		
		// 로그인 설정
		http.formLogin()
			.loginPage("/" + Constant.NOTILES + "/login")
			.successHandler(authenticationSuccessHandler)
			.failureHandler(authenticationFailureHandler)
			.permitAll()
			
		// 로그아웃 설정
			.and()
			.logout()
			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
			.permitAll()
			.logoutSuccessUrl("/" + Constant.NOTILES + "/login")
			.invalidateHttpSession(true);
	}
}
