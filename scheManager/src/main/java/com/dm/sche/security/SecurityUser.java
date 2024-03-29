package com.dm.sche.security;

import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class SecurityUser extends User {
	private static final long serialVersionUID = 1L;

	private Integer idx;		// 사용자 정보 PK
	private String id;			// 아이디
	private String password;	// 비밀번호
	private String realPassword;
	private String name;		// 이름
	private String birth;		// 생년월일 (19990101)
	private String gender;		// 성별 (1:남자, 2:여자)
	private String phone;		// 전화번호 (01012341234)
	private String auth;		// 권한 (A:admin, U:user)
	private Date joinDate;		// 회원가입일
	

	public SecurityUser(String username, 
						String password, 
						String realPassword,
						Integer idx,
						String name,
						String birth,
						String gender,
						String phone,
						String auth,
						Date joinDate,
			Collection<? extends GrantedAuthority> authorities) {

		this(username, password, realPassword, idx, name, birth, gender, phone, auth, joinDate, true, true, true, true, authorities);
		
	}
	
	public SecurityUser(String username, 
						String password,
						String realPassword,
						Integer idx,
						String name,
						String birth,
						String gender,
						String phone,
						String auth,
						Date joinDate,
						boolean enabled, 
						boolean accountNonExpired,
						boolean credentialsNonExpired, 
						boolean accountNonLocked,
						Collection<? extends GrantedAuthority> authorities) {
		
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		
		this.id 		= username;
		this.password 	= password;
		this.realPassword = realPassword;
		this.idx		= idx;
		this.name 		= name;
		this.birth 		= birth;
		this.gender		= gender;
		this.phone		= phone;
		this.auth		= auth;
		this.joinDate	= joinDate;
		
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public String getRealPassword() {
		return realPassword;
	}

	public void setRealPassword(String realPassword) {
		this.realPassword = realPassword;
	}

}
