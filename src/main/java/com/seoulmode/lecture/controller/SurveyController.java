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
		resultMap.put("auth",auth.get(0).toString());
		
		String member_email = SecurityContextHolder.getContext().getAuthentication().getName();
		paramMap.put("MEMBER_EMAIL",member_email);

		if("list".equals(action)) {
			if(((String)resultMap.get("auth")).equals("ROLE_ADMIN")) {
				resultList=(List<Object>) service.getList(paramMap);
			}else {
			resultList=(List<Object>) service.getMemberList(paramMap);
			}
		}else if("insert".equals(action)) {
			
		}else if("insert_register".equals(action)){
//			service.insertObject(paramMap);
		}else if("modify".equals(action)) {
//			resultMap = (Map<String, Object>) service.getObject(paramMap);
		}else if("modify_register".equals(action)){
//			service.insertObject(paramMap);
		}else if("read".equals(action)) {
//			resultMap = (Map<String, Object>) service.getObject(paramMap);
		}else if("delete".equals(action)) {
			
		}else {
			
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
