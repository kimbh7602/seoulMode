package com.seoulmode.lecture.security;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.seoulmode.lecture.dao.ShareDao;

public class CustomizeUserDetailsService implements UserDetailsService{
	
	
	@Autowired
	private ShareDao dao; 
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		String sqlMapId = "member.security_read";
		dataMap.put("MEMBER_EMAIL", username);
		// EMAIl 로  정보 가져오는 쿼리문 짜고, 실행 확인
		Map<String, Object> resultMember = (Map<String, Object>) dao.getObject(sqlMapId, dataMap);

		if (resultMember == null) {
		throw new UsernameNotFoundException("Not found username: "+username);
		}
		sqlMapId = "memberRauthority.security_read";
		dataMap.put("MEMBER_SEQ", resultMember.get("MEMBER_SEQ"));
		List<Object> resultAuthorities = (List<Object>) dao.getList(sqlMapId, resultMember);
		return new MemberInfo(resultMember,	buildUserAuthority(resultAuthorities));
	}
	
	private Set<GrantedAuthority> buildUserAuthority(List<Object> resultAuthorities) {
		Set<GrantedAuthority> resultObject = new HashSet<GrantedAuthority>();
		Iterator iterator = resultAuthorities.iterator();
		while(iterator.hasNext()) {
		Map<String,String> element = (Map<String, String>) iterator.next();
		resultObject.add(new SimpleGrantedAuthority(element.get("AUTHORITY_NAME")));
		}
		return resultObject;
		}
}
