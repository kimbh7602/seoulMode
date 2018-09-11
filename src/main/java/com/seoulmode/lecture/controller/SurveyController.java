package com.seoulmode.lecture.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmode.lecture.component.MapParamCollector;
import com.seoulmode.lecture.security.MemberInfo;
import com.seoulmode.lecture.service.SurveyService;


@Controller
public class SurveyController {
	private final static String MAPPING = "/survey/";
	
	@Autowired
	private SurveyService service;
	
	@RequestMapping(value = MAPPING+"{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam MultiValueMap<Object, Object> paramMultiMap
			,MapParamCollector paramMethodMap, @PathVariable String action,
			ModelAndView modelandView) {

		String viewName = MAPPING + action ;
		
		Map<Object,Object> paramMap = paramMethodMap.getMap();
		Map<String, Object> resultMap = new HashMap<String, Object>() ;
		List<Object> resultList = new ArrayList<Object>();
		String forwardView = (String) paramMap.get("forwardView") ;
		
		List auth = (List) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		paramMap.put("auth",auth.get(0).toString());
		

		String member_name = SecurityContextHolder.getContext().getAuthentication().getName();
		paramMap.put("MEMBER_NAME",member_name);
		
		if(SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")) {
			Object member_email = SecurityContextHolder.getContext().getAuthentication().getPrincipal();			
			paramMap.put("MEMBER_EMAIL",member_email);
		}else {
			MemberInfo member_email = (MemberInfo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			paramMap.put("MEMBER_EMAIL",member_email.getMemberID());
		}
		

		if("list".equals(action)) {
			if(((String)paramMap.get("auth")).equals("ROLE_ADMIN")) {
				resultList=(List<Object>) service.getList(paramMap);
			}else {
			resultList = (List<Object>) service.check_response(resultList=(List<Object>) service.getMemberList(paramMap),paramMap);
			}
		}else if("insert".equals(action)) {
			resultList = (List<Object>) service.getList_insert(paramMap);
		}else if("course_rel_insert".equals(action)){
			service.course_rel_insert(paramMap);
			resultList=(List<Object>) service.getList(paramMap);
		}else if("modify".equals(action)) {
			resultList = (List<Object>) service.getList_Read(paramMap);
		}else if("modify_enrollment".equals(action)) {
			service.survey_modify(paramMap);
			resultList=(List<Object>) service.getList(paramMap);
		}else if("response".equals(action)){
			service.insert_response(paramMap);
			resultList=(List<Object>) service.getList(paramMap);
		}else if("read".equals(action)) {
			resultList = (List<Object>) service.getList_Read(paramMap);
		}else if("delete".equals(action)) {
			service.delete_survey(paramMap);
			resultList=(List<Object>) service.getList(paramMap);
		}else if("response_list".equals(action)){
			// response_list 부분에 대한 데이터를 넣을 수 있는 Service 메서드를 구현해보자아
			resultList = (List<Object>) service.getList(paramMap);
		}else if("response_enrollment".equals(action)) {
			service.insert_subjective_response(paramMap);
			resultList = (List<Object>) service.getList(paramMap);
		}
		
		if(forwardView != null){
			viewName = forwardView;
		}
		
		modelandView.setViewName(viewName);

		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		modelandView.addObject("resultList", resultList);
		return modelandView;
	}
	
}
