package com.seoulmode.lecture.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seoulmode.lecture.dao.ShareDao;
import com.seoulmode.lecture.util.CommonUtil;

@Service
public class AnalysticsService {

	@Autowired
	private ShareDao dao;
	@Autowired
	private CommonUtil commonutil;
	
	public Object getList(Object dataMap) {
		
		Object resultData = dao.getList("member.list",dataMap);
		
		return resultData;
	}
	
	public Object getEaxmColList(Object dataMap) {
		
		Object resultData = dao.getList("analystics.examTableCol",dataMap);
		
		return resultData;
	}

	public Object getExamRowList(Object dataMap) {
	
	Object resultData = dao.getList("analystics.examTableRow",dataMap); 
	
	return resultData;
}

	public Object getExamValueList(Object dataMap) {
	
	Object resultData = dao.getList("analystics.examTableValue",dataMap);
	
	return resultData;
}
	
	public Object getExamList(Object dataMap) {
		
		Object resultData = dao.getList("analystics.examList", dataMap);
		
		return resultData;
	}
	
	public Object getQuestionList(Object dataMap) {
		
		Object resultData = dao.getList("analystics.questionList", dataMap);
		
		return resultData;
	}
	
	public Object getResponseColList(Object dataMap) {
		
		Object resultData = dao.getList("analystics.colList", dataMap);
		
		return resultData;
	}
	
	public Object getResponseRowList(Object dataMap) {
		
		Object resultData = dao.getList("analystics.rowList", dataMap);
		
		return resultData;
	}
	
	public Object getCrossColList(Object dataMap) {
		
		Object resultData = dao.getList("analystics.crossColList", dataMap);
		
		return resultData;
	}
	
	public Object getCrossRowList(Object dataMap) {
		
		Object resultData = dao.getList("analystics.crossRowList", dataMap);
		
		return resultData;
	}
	
	public Object getCrossValList(Object dataMap) {
		
		Object resultData = dao.getList("analystics.crossValueList", dataMap);
		
		return resultData;
	}
	
	public Object getObject(Object dataMap) {
		
		Object resultData = new HashMap();
		List courseList = (List)dao.getList("course.list", dataMap);
		((Map)resultData).put("courseList", courseList);
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
		String uniqueSequence = commonutil.getUniqueSequence();
		paramMap.put("MEMBER_SEQ", uniqueSequence);
		Object resultData = dao.insertObject("member.insert",paramMap);
		
		Object resultKey = dao.insertObject("memberRauthority.insert", paramMap);
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
