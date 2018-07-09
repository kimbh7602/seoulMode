package com.seoulmode.lecture;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmode.lecture.service.SurveyService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	private final static String MAPPING = "/";
	
	@Autowired
	private SurveyService service;
	
	@RequestMapping(value ="/", method= { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionHome(@RequestParam Map<String, Object> paramMap,
			ModelAndView modelandView) {

		String viewName = "/home";
		
		Map<String, Object> resultMap = new HashMap<String, Object>() ;
		List<Object> resultList = new ArrayList<Object>();
		
		String member_email = SecurityContextHolder.getContext().getAuthentication().getName();
		paramMap.put("MEMBER_EMAIL",member_email);
		resultList=(List<Object>) service.getList(paramMap);
		
		List auth = (List) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		resultMap.put("auth",auth.get(0));
		
		modelandView.setViewName(viewName);

		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		modelandView.addObject("resultList", resultList);
		return modelandView;
	}
	
	@RequestMapping(value = MAPPING+"{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam Map<String, Object> paramMap, @PathVariable String action,
			ModelAndView modelandView) {

		String viewName = MAPPING + action ;
		
		Map<String, Object> resultMap = new HashMap<String, Object>() ;
		List<Object> resultList = new ArrayList<Object>();
		
		String member_email = SecurityContextHolder.getContext().getAuthentication().getName();
		paramMap.put("MEMBER_EMAIL",member_email);
		resultList=(List<Object>) service.getList(paramMap);
		
		if("home".equals(action)) {
			viewName = "/home";
		}
		List auth = (List) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		resultMap.put("auth",auth.get(0));
		modelandView.setViewName(viewName);

		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		modelandView.addObject("resultList", resultList);
		return modelandView;
	}
	
}