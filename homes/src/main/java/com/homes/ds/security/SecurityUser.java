package com.homes.ds.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

public class SecurityUser extends User {
	private static final long serialVersionUID = 1L;
	
	private Integer idx;
	private Integer homeIdx;
	private String id;
	private String password;
	private String name;
	
	public SecurityUser (
				String username, 
				String password, 
				Integer idx,
				Integer homeIdx,
				String name,
				Collection<? extends GrantedAuthority> authorities) {
		
		this(username, password, idx, homeIdx, name, true, true, true, true, authorities);
	}
	
	public SecurityUser (
			String username,
			String password,
			Integer idx,
			Integer homeIdx,
			String name,
			boolean enabled,
			boolean accountNonExpired,
			boolean credentialsNonExpired,
			boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		
		this.id 			= username;
		this.password 		= password;
		this.idx 			= idx;
		this.homeIdx		= homeIdx;
		this.name			= name;
	}

	public Integer getIdx() {
		return idx;
	}

	public void setIdx(Integer idx) {
		this.idx = idx;
	}

	public Integer getHomeIdx() {
		return homeIdx;
	}

	public void setHomeIdx(Integer homeIdx) {
		this.homeIdx = homeIdx;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
