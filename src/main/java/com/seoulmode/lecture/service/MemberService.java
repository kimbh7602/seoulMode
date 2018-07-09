package com.seoulmode.lecture.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seoulmode.lecture.dao.ShareDao;
import com.seoulmode.lecture.util.CommonUtil;

@Service
public class MemberService {

	@Autowired
	private ShareDao dao;
	@Autowired
	private CommonUtil commonutil;
	
	public Object getList(Object dataMap) {
		
		Object resultData = dao.getList("member.list",dataMap);
		
		return resultData;
	}
	
	public Object getObject(Object dataMap) {
		
		Object resultData = dao.getObject("member.read",dataMap);
		
		return resultData;
	}
	
	public Object readModify(Object dataMap) {
		Object resultData = dao.getObject("member.read", dataMap);
		List courseList = (List)dao.getList("course.list", dataMap);
		((Map)resultData).put("courseList", courseList);
		List authorityList = (List)dao.getList("authority.list", dataMap);
		((Map)resultData).put("authorityList", authorityList);
		return resultData;
	}
	
	public Object insertObject(Map<String,Object> paramMap) {
		String uniqueSequence = (String) paramMap.get("MEMBER_SEQ");
		Object resultData;
		if("".equals(uniqueSequence)){
			// 해당 SEQ가 없으면 insert
			uniqueSequence = commonutil.getUniqueSequence();
			paramMap.put("MEMBER_SEQ", uniqueSequence);
			resultData = dao.insertObject("survey.insert",paramMap);
		}else {
			// 있으면 update
			resultData = dao.getObject("survey.update",paramMap); 	
		}
		return resultData;
	}
	
	public Object updateObject(Object dataMap) {
		Object resultData = dao.updateObject("member.update", dataMap);
		Object resultKey = dao.updateObject("memberRauthority.update", dataMap);
		return resultData;
	}
	
	public Object deleteObject(Object dataMap) {
		Object resultKey = dao.deleteObject("memberRauthority.delete", dataMap);
		Object resultData = dao.deleteObject("member.delete", dataMap);
		
		return resultData;
	}
}
