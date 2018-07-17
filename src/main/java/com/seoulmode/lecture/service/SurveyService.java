package com.seoulmode.lecture.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
	
	public Object getList_flag(Object dataMap) {
		
		Object resultData = dao.getList("survey.flag_list",dataMap);
		
		return resultData;
	}
	
	public Object getObject(Object dataMap) {
		
		Object resultData = null; 
		return resultData;
	}
	
	public Object getList_Read(Object dataMap) {
		List inputdata = new ArrayList();
		
		List<Map<String,Object>> question_resultData = (List<Map<String, Object>>) dao.getList("survey.question_read",dataMap);
		inputdata.add(question_resultData);
		for(int i =0; i<question_resultData.size();i++) {
			Object tempdata = question_resultData.get(i);
			Object view_resultData = dao.getList("survey.view_read",tempdata);
			inputdata.add(view_resultData);
		}
		return inputdata;
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
			resultData = dao.insertObject("survey.survey_insert",paramMap);
		}else {
			// 있으면 update
			resultData = dao.getObject("survey.update",paramMap); 
		}
		
		resultData = uniqueSequence;
		
		return resultData;
	}
	
	public Object insertView(Map<Object,Object> paramMap) {
		String uniqueSequence;
		List<Map<String,Object>> inputdata = new ArrayList<Map<String,Object>>();
		
		uniqueSequence = commonutil.getUniqueSequence();		
		paramMap.put("QUESTION_SEQ", uniqueSequence);
		
		Object resultData = dao.insertObject("survey.ques_insert",paramMap);
		
		String[] test = (String[])paramMap.get("views");
		for(int i =1;i<test.length; i++) {
			Map<String,Object> inputMap = new HashMap<String, Object>();
			String view_uniqueSequence = commonutil.getUniqueSequence();
			inputMap.put("QEUSTION_SEQ",uniqueSequence);
			inputMap.put("VIEW_SEQ",view_uniqueSequence);
			inputMap.put("VIEW_NAME",test[i]);
			inputdata.add(inputMap);
		}
		paramMap.put("inputdata", inputdata);

		dao.insertObject("survey.view_insert",paramMap);
		
		return paramMap; 
	}
}
