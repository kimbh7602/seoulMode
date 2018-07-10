package com.seoulmode.lecture.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seoulmode.lecture.dao.ShareDao;
import com.seoulmode.lecture.util.CommonUtil;

@Service
public class SurveyService {
	
	@Autowired
	private ShareDao dao;
	
	@Autowired
	private CommonUtil commonutil;
	
	public Object getList(Object dataMap) {
		
		Object resultData = dao.getList("survey.list",dataMap);
		
		return resultData;
	}
	
	public Object getObject(Object dataMap) {
		
		Object resultData = dao.getObject("survey.read",dataMap);
		
		return resultData;
	}
	
	public Object getMemberList(Object dataMap) {
		Object resultData = dao.getList("survey.member_list",dataMap);
		
		return resultData;
	}
	
	public Object insertObject(Map<Object,Object> paramMap) {
		String uniqueSequence = (String) paramMap.get("SURVEY_SEQ");
		Object resultData;
		if("".equals(uniqueSequence)){
			// 해당 SEQ가 없으면 insert
			uniqueSequence = commonutil.getUniqueSequence();
			paramMap.put("SURVEY_SEQ", uniqueSequence);
			resultData = dao.insertObject("survey.insert",paramMap);
		}else {
			// 있으면 update
			resultData = dao.getObject("survey.update",paramMap); 
		}
		
		
		return resultData;
	}
}
