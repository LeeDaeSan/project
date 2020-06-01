package com.homes.ds.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class SecurityUser extends User {

	private Integer idx;
	private String id;
	private String password;
	private String realPassword;
	private String name;
	
	public SecurityUser (
				String username, 
				String password, 
				String realPassword, 
				Integer idx, 
				String name,
				Collection<? extends GrantedAuthority> authorities) {
		
		this(username, password, realPassword, idx, name, true, true, true, true, authorities);
	}
	
	public SecurityUser (
			String username,
			String password,
			String realPassword,
			Integer idx,
			String name,
			boolean enabled,
			boolean accountNonExpired,
			boolean credentialsNonExpired,
			boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		
		this.id 			= username;
		this.password 		= password;
		this.realPassword 	= realPassword;
		this.idx 			= idx;
		this.name			= name;
		
	}

	public Integer getIdx() {
		return idx;
	}

	public void setIdx(Integer idx) {
		this.idx = idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRealPassword() {
		return realPassword;
	}

	public void setRealPassword(String realPassword) {
		this.realPassword = realPassword;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
