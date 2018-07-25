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
	
	public Object insert_response(Map<Object,Object> dataMap) {
		Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
		List<Map<Object,Object>> inputList = new ArrayList<Map<Object,Object>>();		// 설문에 대한 데이터
		int VIEW_IDX = 0;
		String[] a_OBJECT_PLURAL_RESPONCE = null;
		String[] a_OBJECT_PLURAL_IDX_per_QUESTION = null;
		String s_OBJECT_PLURAL_RESPONCE = null;
		String s_OBJECT_PLURAL_IDX_per_QUESTION = null;
		String s_SURVEY_SEQ = (String) dataMap.get("SURVEY_SEQ");				// 설문 SEQ 값 하나 
		String[] a_QUESTION_SEQ = (String[]) dataMap.get("QUESTION_SEQ");			// 질문 SEQ -> 질문 갯수 
		String[] a_QUESTION_FLAG = (String[]) dataMap.get("QUESTION_FLAG");			// 질문 플래그 
		
		
		String s_OBJECT_PLURAL_IDX = (String) dataMap.get("OBJECT_PLURAL_IDX");		// 객관식 복수 질문 갯수 값 꺼내기 
		String s_SUBJECTIVE_IDX = (String) dataMap.get("SUBJECTIVE_IDX");			// 주솬식 질문 갯수 값 꺼내기 
		
		int question_count = a_QUESTION_SEQ.length;						// 질문갯수 
		int SUBJECTIVE_IDX = Integer.parseInt(s_SUBJECTIVE_IDX);		// 주관식 단답 + 서술형 질문 갯수
		int OBJECT_PLURAL_IDX = Integer.parseInt(s_OBJECT_PLURAL_IDX);		// 객관식 복수 질문 총 갯수
		
		
		if(OBJECT_PLURAL_IDX >1) {					// 객관식 복수 문제 수 
			a_OBJECT_PLURAL_IDX_per_QUESTION = (String[]) dataMap.get("VIEW_IDX");
			if(Integer.parseInt(a_OBJECT_PLURAL_IDX_per_QUESTION[0]) >1) {
				a_OBJECT_PLURAL_RESPONCE = (String[]) dataMap.get("OBJECTIVE_RESPONSE_PLURAL");
			}else {
				s_OBJECT_PLURAL_RESPONCE = (String) dataMap.get("OBJECTIVE_RESPONSE_PLURAL");
			}
		}else {
			s_OBJECT_PLURAL_IDX_per_QUESTION = (String) dataMap.get("VIEW_IDX");
			if(Integer.parseInt(s_OBJECT_PLURAL_IDX_per_QUESTION) >1) {
				a_OBJECT_PLURAL_RESPONCE = (String[]) dataMap.get("OBJECTIVE_RESPONSE_PLURAL");
			}else {
				s_OBJECT_PLURAL_RESPONCE = (String) dataMap.get("OBJECTIVE_RESPONSE_PLURAL");
			}
		}
		
		if(SUBJECTIVE_IDX > 1) {
			String[] SUBJECTIVE_RESPONCE = (String[]) dataMap.get("SUBJECTIVE_RESPONSE");
		}else {			
			String SUBJECTIVE_RESPONCE = (String) dataMap.get("SUBJECTIVE_RESPONSE");
		}
		
		
		for(int i =0;i<question_count;i++) {	// 질문 갯수만큼 반복 
			if( a_QUESTION_FLAG[i].equals("UUID_8000")){		// 객관식 단수
				// 순서대로 도는거니까 여기서 List 에 값을 넣자
				String value = (String) dataMap.get("OBJECTIVE_RESPONSE_SINGULAR,"+a_QUESTION_SEQ[i]);
				
				inputMap.put("OBJECTIVE_RESPONSE",value);
				
				// 다른것도 추가 
			}else if(a_QUESTION_FLAG[i].equals("UUID_8001")) {		// 객관식 복수
				String value = null;
				if(OBJECT_PLURAL_IDX > 1) {
					for(int j =0;j < Integer.parseInt(a_OBJECT_PLURAL_IDX_per_QUESTION[VIEW_IDX]);j++) {
						 value = a_OBJECT_PLURAL_RESPONCE[j];
						 inputMap.put("OBJECTIVE_RESPONSE",value);
					}
				}else {
					for(int j=0;j<Integer.parseInt(a_OBJECT_PLURAL_IDX_per_QUESTION[VIEW_IDX]);j++) {
						 value = a_OBJECT_PLURAL_RESPONCE[j];
					}
					
				}
			}else if(a_QUESTION_FLAG[i].equals("UUID_8002")) {		// 주관식 단답
				
			}else if(a_QUESTION_FLAG[i].equals("UUID_8003")) {		// 서술형
					
			}else if(a_QUESTION_FLAG[i].equals("UUID_8004")) {		// 만족도
				
			}
		}
		
		for(int i =0;i<question_count + OBJECT_PLURAL_IDX-1;i++) {		// Dao에 insert 쿼리문 넣는 곳.
			
		}
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

			resultData = dao.updateObject("question_update",inputMap);			
			dao.updateObject("view_update",inputMap);

		}

		
		return resultData;
	}
}
