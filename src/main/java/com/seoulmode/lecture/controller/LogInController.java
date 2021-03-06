package com.seoulmode.lecture.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmode.lecture.service.LoginService;

@Controller
public class LogInController {
	
	private final static String MAPPING = "/login/";
	
	@Autowired
	private LoginService service;

	@RequestMapping(value = MAPPING + "{action}",method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView actionMethod(@RequestParam Map<String,Object> paramMap,
			@PathVariable String action, ModelAndView modelandView) {
		
		String viewName = MAPPING + action;
		String forwardView = (String) paramMap.get("forwardView");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Object> resultlist = new ArrayList<Object>();
		
		if("login".equalsIgnoreCase(action)) {
			
		}else if("loginform".equalsIgnoreCase(action)) {
			resultlist = (List)service.getList(paramMap);
		}
		modelandView.setViewName(viewName);
		
		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		modelandView.addObject("resultList", resultlist);
		return modelandView;
	}
	

}
