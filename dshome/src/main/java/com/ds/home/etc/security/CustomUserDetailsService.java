package com.ds.home.etc.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.ds.home.member.mapper.MemberMapper;
import com.ds.home.model.Member;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Member member = memberMapper.getMember(username);
		
		String password = member.getPassword(); // db에 저장된 password
		
		List<String> roles = new ArrayList<String>();
		roles.add("USER");
		
		User user = new SecurityUser(
					username, 
					password, 
					member.getMemberIdx(),
					true,
					true,
					true,
					true,
					makeGrantedAuthority(roles));
		
		return user;
	}
	
	private static List<GrantedAuthority> makeGrantedAuthority (List<String> roles) {
		List<GrantedAuthority> list = new ArrayList<>();
		roles.forEach(role -> list.add(new SimpleGrantedAuthority("USER")));
		
		return list;
	}
	
}
