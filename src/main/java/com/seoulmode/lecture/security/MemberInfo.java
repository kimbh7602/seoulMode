package com.seoulmode.lecture.security;

import java.util.Collection;
import java.util.Map;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

public class MemberInfo implements UserDetails {
	private String memberID;
	private String memberName;
	private String password;
	private Set<GrantedAuthority> authorities;

	public MemberInfo(Map<String, Object> resultMember, Set<GrantedAuthority> authorities) {
		this.memberID = (String) resultMember.get("MEMBER_SEQ");
		this.memberName = (String) resultMember.get("MEMBER_NAME");
		this.password = (String) resultMember.get("MEMBER_PASSWORD");
		this.authorities = authorities;
	}
	User user;
	

	public String getMemberID() {
		return memberID;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getPassword() {
		return null;
	}

	@Override
	public String getUsername() {
		return memberName;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
}