package com.seoulmode.lecture.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.seoulmode.lecture.service.AnalysticsService;
import com.seoulmode.lecture.service.LoginService;
import com.seoulmode.lecture.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AnalysticsController {
	private final static String MAPPING = "/analystics/";
	
	@Autowired
	private AnalysticsService service;
	
	@RequestMapping(value = MAPPING+"{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam Map<String, Object> paramMap, @PathVariable String action,
			ModelAndView modelandView) {

		String viewName = MAPPING + action ;
		
		Map<String, Object> resultMap = new HashMap<String, Object>() ;
		List<Object> resultList = new ArrayList<Object>();

		if("read".equals(action)) {
			resultMap = (Map)service.getObject(paramMap);
		} else if("examSelect".equals(action)) {
			resultList = (List)service.getExamList(paramMap);
		}
		
		
		modelandView.setViewName(viewName);

		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		modelandView.addObject("resultList", resultList);
		return modelandView;
	}
	
	@RequestMapping(value ="/examAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Object> examAjax(@RequestParam Map<String, Object> paramMap) {
		
		System.out.println("exam");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Object> resultList = new ArrayList<Object>();
		
		resultList = (List)service.getExamList(paramMap);
		
		resultMap.put("data", resultList);
		
		return resultMap;
		
	}
	
	@RequestMapping(value ="/questionAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Object> questionAjax(@RequestParam Map<String, Object> paramMap) {
		
		System.out.println("question");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Object> resultList = new ArrayList<Object>();
		
		resultList = (List)service.getQuestionList(paramMap);
		
		resultMap.put("data", resultList);
		
		return resultMap;
		
	}
	
}
