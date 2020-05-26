package com.dm.sche;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * jar 개발 전용
 * 
 */
@SpringBootApplication
//DB Access 임시 막기
//@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
public class ScheManagerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ScheManagerApplication.class, args);
	}

}


/**
 * war 배포 전용
 * @author mijung
 *
 */
/*@Configuration
@EnableAutoConfiguration
@ComponentScan
public class ScheManagerApplication extends SpringBootServletInitializer {


	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		
		return builder.sources(ScheManagerApplication.class);
	}
}
*/