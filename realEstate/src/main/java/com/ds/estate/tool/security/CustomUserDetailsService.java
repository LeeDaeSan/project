package com.ds.estate.tool.security;

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

import com.ds.estate.model.Member;
import com.ds.estate.model.mapper.MemberMapper;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Member member = memberMapper.getMember(username);
		
		// 서버에서 조회해 온 패스워드 암호화
		String password = new BCryptPasswordEncoder().encode(member.getPassword());
		// 권한 부여
		List<String> roles = new ArrayList<String>();
		roles.add("USER");
		
		User user = new SecurityUser(
					username, 
					password, 
					member.getMemberIdx(), 
					member.getMemberName(), 
					true,
					true,
					true,
					true,
					makeGrantedAuthority(roles));
		
		return user;
	}
	
	private static List<GrantedAuthority> makeGrantedAuthority (List<String> roles) {
		List<GrantedAuthority> list = new ArrayList<GrantedAuthority>();
		
		roles.forEach(role -> list.add(new SimpleGrantedAuthority(role)));
		
		return list;
	}
}
