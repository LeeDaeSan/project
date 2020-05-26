package com.dm.sche.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.dm.sche.filter.ScheFilter;

@Configuration
public class FilterConfig {

	@Bean
	public FilterRegistrationBean getFilterRegistrationBean () {
		FilterRegistrationBean registrationBean = new FilterRegistrationBean();
		
		registrationBean.setFilter(new ScheFilter());
		
		return registrationBean;
	}
	
}
