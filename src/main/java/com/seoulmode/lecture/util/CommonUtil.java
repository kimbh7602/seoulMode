package com.seoulmode.lecture.util;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class CommonUtil {
	/**
	 * Unique sequence Key 생성 
	 * @param 
	 * @return String 
	 */
    public String getUniqueSequence() {
		UUID uuid = UUID.randomUUID();
		return uuid.toString().replaceAll("-", "");
//    	String longTime = new Long((new Date().getTime())).toString();
//        return longTime;
    }
    
	/**
	 * DB sequence Key List 생성 
	 * @param int cnt
	 * @return List 
	 */
	public List<String> getSequenceList(int cnt) {
		List<String> result = new ArrayList<String>();
		UUID uuid;
		for(int i=0; i<= cnt; i++){
			uuid = UUID.randomUUID();
			result.add(uuid.toString().replaceAll("-", "")+i);
		}
		
		return result ;
	}
	
	public String PasswordEncoderGenerator(String password) {
		String hashedPassword = password;
		if(password != null){
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			hashedPassword = passwordEncoder.encode(password);
		}
		return hashedPassword;
	}
}
