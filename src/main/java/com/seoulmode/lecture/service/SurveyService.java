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
		for(int i=0;i<((List)resultData).size() ;i++) {
			Map<String,Object> inputData = new HashMap<String,Object>();
			inputData =  (Map<String, Object>) dao.getObject("organization_list",dataMap);
			Object ORGANIZATION_SEQ = inputData.get("ORGANIZATION_SEQ");
			Object ORGANIZATION_NAME = inputData.get("ORGANIZATION_NAME");
			((Map<String, Object>) ((List)resultData).get(i)).put("ORGANIZATION_SEQ",ORGANIZATION_SEQ);
			((Map<String, Object>) ((List)resultData).get(i)).put("ORGANIZATION_NAME",ORGANIZATION_NAME);
			((Map<String, Object>) ((List)resultData).get(i)).put("forwardView","/survey/list");
		}
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
	
	public Object getMemberList(Object dataMap) {
		Object resultData = dao.getList("survey.member_list",dataMap);
		Object resultData2 = dao.getList("organization_list",dataMap);

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
		List<Map<Object,Object>> inputList = new ArrayList<Map<Object,Object>>();		// 설문에 대한 데이터
		// MEMBER_SEQ 구해야함.
		// MEMBER_EMAIL 로 찾아오자. SM_MEMBER 에서
		String MEMBER_SEQ = (String) ((Map<String,Object>)dao.getObject("member.security_read", dataMap)).get("MEMBER_SEQ");
		
		// COURSE_SEQ 구해야함.
		// SURVEY_SERIES 구해야함.
		// SURVEY_SEQ 로 SM_COURSEREREXAM에서 구해오자.
		Map<String,Object> coursereaxam = new HashMap<String,Object>();
		coursereaxam = (Map<String,Object>)dao.getObject("survey.courserexam", dataMap);
		String COURSE_SEQ = (String) coursereaxam.get("COURSE_SEQ");
		String SURVEY_SERIES = String.valueOf(coursereaxam.get("SURVEY_SERIES"));
		
		int OBJECT_PLURAL_COUNT =0;
		int SUBJECTIVE_COUNT =0;
		String[] a_OBJECT_PLURAL_RESPONCE = (String[]) dataMap.get("OBJECTIVE_RESPONSE_PLURAL");							// 질문에 대항 응답 (객관식 복수 ) 복수응답시
		//String[] a_OBJECT_PLURAL_IDX_per_QUESTION = null;					복수든 단수든 그냥 String 으로 날라옴
//		String s_OBJECT_PLURAL_RESPONCE = null;								// 질문에 대한 응답 (객관식 복수) 단수응답시
		//복수인데 단수응답을 한다고? 안댐.
		String s_OBJECT_PLURAL_IDX_per_QUESTION = null;
		String[] a_OBJECT_PLURAL_IDX_per_QUESTION = null;
		
		String SURVEY_SEQ = (String) dataMap.get("SURVEY_SEQ");				// 설문 SEQ 값 하나 
		String[] a_QUESTION_SEQ = (String[]) dataMap.get("QUESTION_SEQ");			// 질문 SEQ -> 질문 갯수 
		String[] a_QUESTION_FLAG = (String[]) dataMap.get("QUESTION_FLAG");			// 질문 플래그 
		String[] a_SUBJECTIVE_RESPONCE =null;
		String s_SUBJECTIVE_RESPONCE = null;
		String s_OBJECT_PLURAL_IDX = (String) dataMap.get("OBJECT_PLURAL_IDX");		// 객관식 복수 질문 갯수 값 꺼내기 
		String s_SUBJECTIVE_IDX = (String) dataMap.get("SUBJECTIVE_IDX");			// 주솬식 질문 갯수 값 꺼내기 
				
		int question_count = a_QUESTION_SEQ.length;						// 질문갯수 
		int SUBJECTIVE_IDX = Integer.parseInt(s_SUBJECTIVE_IDX);		// 주관식 단답 + 서술형 질문 갯수
		int OBJECT_PLURAL_IDX = Integer.parseInt(s_OBJECT_PLURAL_IDX);		// 객관식 복수 질문 총 갯수
		
		
		// 지금 필요한 것 -> 복수 질문 당 응답 갯수. 그에 따라서 응답 insert 
		if(OBJECT_PLURAL_IDX > 1) {		// 객관식 복수 질문이 2개 이상이면 
			// VIEW_IDX 가 [] 로 들어오니까 이렇게 저장
			a_OBJECT_PLURAL_IDX_per_QUESTION = (String[]) dataMap.get("VIEW_IDX");		// 객관식 복수 응답 갯수
		}else {
			// 아니면 String 으로 단일 들어옴.
			s_OBJECT_PLURAL_IDX_per_QUESTION = (String) dataMap.get("VIEW_IDX");		// 객관식 복수 응답 갯수
		}
		
		if(SUBJECTIVE_IDX > 1) {						 // 주관식 문제 수
			a_SUBJECTIVE_RESPONCE = (String[]) dataMap.get("SUBJECTIVE_RESPONSE");
		}else {			
			s_SUBJECTIVE_RESPONCE = (String) dataMap.get("SUBJECTIVE_RESPONSE");
		}
		
		
		
		for(int i =0;i<question_count;i++) {	// 질문 갯수만큼 반복 
/*			Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
			inputMap.put("QUESTION_SEQ", a_QUESTION_SEQ[i]);
			inputMap.put("MEMBER_SEQ", MEMBER_SEQ);
			inputMap.put("COURSE_SEQ", COURSE_SEQ);
			inputMap.put("SURVEY_SERIES", SURVEY_SERIES);
			inputMap.put("SURVEY_SEQ", SURVEY_SEQ);*/

			if( a_QUESTION_FLAG[i].equals("UUID_8000")){		// 객관식 단수
				// 순서대로 도는거니까 여기서 List 에 값을 넣자
				String value = (String) dataMap.get("OBJECTIVE_RESPONSE_SINGULAR,"+a_QUESTION_SEQ[i]);		// 객관식 단수 형태가 ,SEQ 이런 형태임.
				Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
				inputMap = getMap( a_QUESTION_SEQ[i],MEMBER_SEQ,COURSE_SEQ,SURVEY_SERIES,SURVEY_SEQ);
				inputMap.put("OBJECTIVE_RESPONSE",value);
				inputMap.put("SUBJECTIVE_RESPONSE","");

				inputList.add(inputMap);
				// 다른것도 추가 
			}else if(a_QUESTION_FLAG[i].equals("UUID_8001")) {		// 객관식 복수
				String value = null;
				// 객관식 복수 문제수가 2이상이면, 이를 구분하는 방식도 필요함.
				// 객관식 복수 문제수가 1이면 그으냥 넣으면 되는부분.
				if(OBJECT_PLURAL_IDX > 1) {
					for(int j =0;j < Integer.parseInt(a_OBJECT_PLURAL_IDX_per_QUESTION[OBJECT_PLURAL_COUNT]);j++) {
						Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
						inputMap = getMap( a_QUESTION_SEQ[i],MEMBER_SEQ,COURSE_SEQ,SURVEY_SERIES,SURVEY_SEQ);
						value = a_OBJECT_PLURAL_RESPONCE[OBJECT_PLURAL_COUNT];
						inputMap.put("OBJECTIVE_RESPONSE",value);
						inputMap.put("SUBJECTIVE_RESPONSE","");
						OBJECT_PLURAL_COUNT++;
						
						inputList.add(inputMap);

					}
				}else {
					for(int j =0;j < Integer.parseInt(s_OBJECT_PLURAL_IDX_per_QUESTION);j++) {
						Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
						inputMap = getMap( a_QUESTION_SEQ[i],MEMBER_SEQ,COURSE_SEQ,SURVEY_SERIES,SURVEY_SEQ);
						value = a_OBJECT_PLURAL_RESPONCE[OBJECT_PLURAL_COUNT];
						inputMap.put("OBJECTIVE_RESPONSE",value);
						inputMap.put("SUBJECTIVE_RESPONSE","");
						OBJECT_PLURAL_COUNT++;

						inputList.add(inputMap);
					}
					
				}
			}else if(a_QUESTION_FLAG[i].equals("UUID_8002")) {		// 주관식 단답
				String value = null;
				if(SUBJECTIVE_IDX >1) {
					Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
					inputMap = getMap( a_QUESTION_SEQ[i],MEMBER_SEQ,COURSE_SEQ,SURVEY_SERIES,SURVEY_SEQ);
					value = a_SUBJECTIVE_RESPONCE[SUBJECTIVE_COUNT];
					SUBJECTIVE_COUNT++;
					inputMap.put("SUBJECTIVE_RESPONSE", value);
					inputMap.put("OBJECTIVE_RESPONSE","");
					
					inputList.add(inputMap);
				}else {
					Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
					inputMap = getMap( a_QUESTION_SEQ[i],MEMBER_SEQ,COURSE_SEQ,SURVEY_SERIES,SURVEY_SEQ);
					value = s_SUBJECTIVE_RESPONCE;
					inputMap.put("SUBJECTIVE_RESPONSE", value);
					inputMap.put("OBJECTIVE_RESPONSE","");
					
					inputList.add(inputMap);
				}
			}else if(a_QUESTION_FLAG[i].equals("UUID_8003")) {		// 서술형
				String value = null;
				if(SUBJECTIVE_IDX >1) {
					Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
					inputMap = getMap( a_QUESTION_SEQ[i],MEMBER_SEQ,COURSE_SEQ,SURVEY_SERIES,SURVEY_SEQ);
					value = a_SUBJECTIVE_RESPONCE[SUBJECTIVE_COUNT];
					SUBJECTIVE_COUNT++;
					inputMap.put("SUBJECTIVE_RESPONSE", value);
					inputMap.put("OBJECTIVE_RESPONSE","");
					
					inputList.add(inputMap);
				}else {
					Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
					inputMap = getMap( a_QUESTION_SEQ[i],MEMBER_SEQ,COURSE_SEQ,SURVEY_SERIES,SURVEY_SEQ);
					value = s_SUBJECTIVE_RESPONCE;
					inputMap.put("SUBJECTIVE_RESPONSE", value);
					inputMap.put("OBJECTIVE_RESPONSE","");
					
					inputList.add(inputMap);
				}
			}else if(a_QUESTION_FLAG[i].equals("UUID_8004")) {		// 만족도
				Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
				inputMap = getMap( a_QUESTION_SEQ[i],MEMBER_SEQ,COURSE_SEQ,SURVEY_SERIES,SURVEY_SEQ);
				String value = (String) dataMap.get("SATISFACTION_RESPONSE,"+a_QUESTION_SEQ[i]);		// 객관식 단수 형태가 ,SEQ 이런 형태임.
				
				inputMap.put("OBJECTIVE_RESPONSE",value);
				inputMap.put("SUBJECTIVE_RESPONSE","");
				
				inputList.add(inputMap);
			}
			
		}
		Map<String,Object> inputdata = new HashMap<String,Object>();
		inputdata.put("inputList", inputList);
		Object resultData = dao.insertObject("survey.insert_response",inputdata);
		
		return resultData;
		
	}
	
	public Map<Object,Object> getMap(String QUESTION_SEQ, String MEMBER_SEQ, String COURSE_SEQ, String SURVEY_SERIES, String SURVEY_SEQ){
		Map<Object,Object> inputMap = new HashMap<Object,Object>();		 // 한 질문에 대한 데이터
		inputMap.put("QUESTION_SEQ", QUESTION_SEQ);
		inputMap.put("MEMBER_SEQ", MEMBER_SEQ);
		inputMap.put("COURSE_SEQ", COURSE_SEQ);
		inputMap.put("SURVEY_SERIES", SURVEY_SERIES);
		inputMap.put("SURVEY_SEQ", SURVEY_SEQ);
		
		return inputMap;
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
