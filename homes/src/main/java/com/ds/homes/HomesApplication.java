package com.ds.homes;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class HomesApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(HomesApplication.class, args);
	}

	@Override protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) { 
		return builder.sources(HomesApplication.class); 
	}
}
