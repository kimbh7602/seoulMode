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
	
	public Object getList_insert(Object dataMap) {
		
		List resultData = new ArrayList();
		
		Object resultData_ques = dao.getList("survey.flag_list",dataMap);
		
		Object resultData_course = dao.getList("survey.course_list",dataMap);
		
		resultData.add(resultData_ques);
		resultData.add(resultData_course);
		
		
		return resultData;
	}
	
	public Object getObject(Object dataMap) {
		
		Object resultData = null;
		return resultData;
	}
	
	public Object getList_Read(Object dataMap) {
		
		List<Map<String,Object>> question_resultData = (List<Map<String, Object>>) dao.getList("survey.question_read",dataMap);
		for(int i =0; i<question_resultData.size();i++) {
			Object tempdata = question_resultData.get(i);
			List<Map<String,Object>> view_resultData = (List<Map<String, Object>>) dao.getList("survey.view_read",tempdata);
			if(view_resultData.isEmpty()) {
				Map<String,Object> dummy = new HashMap<String,Object>();
				dummy.put("VIEWS", "dummy");
				view_resultData.add(dummy);
			}
			question_resultData.get(i).put("VIEWS",view_resultData);
		}
		return question_resultData;
	}
	
	public Object getMemberList(Object dataMap) {
		Object resultData = dao.getList("survey.member_list",dataMap);
		
		return resultData;
	}
	
	public Object insertSurvey(Map<Object,Object> paramMap) {
		String uniqueSequence = (String) paramMap.get("SURVEY_SEQ");
		Object resultData;
		if("".equals(uniqueSequence)){
			// 해당 SEQ가 없으면 insert
			uniqueSequence = commonutil.getUniqueSequence();
			paramMap.put("SURVEY_SEQ", uniqueSequence);
			resultData = dao.insertObject("survey.survey_insert",paramMap);
		}else {
			// 있으면 update
			resultData = dao.getObject("survey.survey_update",paramMap); 
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
		
		String[] views_name = (String[])paramMap.get("views");
		String[] views_num = (String[])paramMap.get("views_num");
		for(int i =0;i<views_name.length; i++) {
			Map<String,Object> inputMap = new HashMap<String, Object>();
			String view_uniqueSequence = commonutil.getUniqueSequence();
			inputMap.put("QEUSTION_SEQ",uniqueSequence);
			inputMap.put("VIEW_SEQ",view_uniqueSequence);
			inputMap.put("VIEW_NAME",views_name[i]);
			inputMap.put("VIEW_NUM",views_num[i]);
			inputdata.add(inputMap);
		}
		paramMap.put("inputdata", inputdata);

		dao.insertObject("survey.view_insert",paramMap);
		
		return paramMap; 
	}

	public Object course_rel_insert(Map<Object, Object> paramMap) {
		Object resultData = dao.insertObject("survey.course_rel_insert",paramMap);
		
		return resultData;
	}
	
	public Object insert_response(Object dataMap) {
		//응답 넣는 데이터 살펴보고, 쿼리몬도 다시 짜서, SM_SURVEY_RESPONSE 테이블에 값을 넣어보자!!
		Object resultData = dao.insertObject("survey.insert_response",dataMap);
		
		return resultData;
		
	}
	
	public Object delete_survey(Object dataMap) {
		
		Object resultData = dao.getObject("survey.question_seq",dataMap);
		dao.deleteObject("survey.survey_delete_response",resultData);
		dao.deleteObject("survey.survey_delete_course",resultData);
		dao.deleteObject("survey.survey_delete_view",resultData);
		dao.deleteObject("survey.survey_delete_question",resultData);
		dao.deleteObject("survey.survey_delete",resultData);
		
		return resultData;
		
	}
	
	public Object survey_modify(Map<Object,Object> dataMap) {
		
		List<Map<String,Object>> inputdata = new ArrayList<Map<String,Object>>();
		Object resultData = null;
		String[] QUESTION_NAME = (String[]) dataMap.get("QUESTION_NAME");
		String[] QUESTION_SEQ = (String[]) dataMap.get("QUESTION_SEQ");
		String[] VIEW_SEQ = (String[]) dataMap.get("VIEW_SEQ");
		String[] VIEW_NAME = (String[]) dataMap.get("VIEW_NAME");
		for(int i =0;i<QUESTION_NAME.length;i++) {
			Map<String,Object> inputMap = new HashMap<String,Object>();
			
			inputMap.put("QUESTION_NAME",QUESTION_NAME[i]);
			inputMap.put("QUESTION_SEQ",QUESTION_SEQ[i]);
			inputMap.put("VIEW_SEQ",VIEW_SEQ[i]);
			inputMap.put("VIEW_NAME",VIEW_NAME[i]);
			/*			
			inputMap.put("QUESTION_NAME",QUESTION_NAME[i]);
			inputMap.put("QUESTION_SEQ",QUESTION_SEQ[i]);
			inputMap.put("VIEW_SEQ",VIEW_SEQ[i]);
			inputMap.put("VIEW_NAME",VIEW_NAME[i]);
			inputdata.add(inputMap);
			*/
			resultData = dao.updateObject("question_update",inputMap);			
			dao.updateObject("view_update",inputMap);

		}
//		dataMap.put("inputdata",inputdata);
//		Object resultData = dao.updateObject("question_update",dataMap);			
//		dao.updateObject("view_update",dataMap);
		
		return resultData;
	}
}
