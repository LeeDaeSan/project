package com.dshome.system.etc.config;

import javax.sql.DataSource;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataSourceConfig {

	/**
	 * Database source 연동
	 * 
	 * @return
	 */
	@ConfigurationProperties(prefix = "spring.datasource")
	public DataSource dataSource () {
		return DataSourceBuilder.create().build();
	}
}
