package com.ds.home.etc.config;
public class WebSecurityConfig {
}
/*
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	/*
	// @Autowired
	// private CustomUserDetailsService customUserDetailsService;
	
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
		
		http.authorizeRequests().anyRequest().permitAll();
		
		/*
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
*/
