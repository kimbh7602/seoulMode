package com.seoulmode.lecture.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
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
		
		// Left 를 위한 권한 가져오기
		List auth = (List) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		resultMap.put("auth",auth.get(0).toString());
		
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
		List<Object> colList = new ArrayList<Object>();
		List<Object> rowList = new ArrayList<Object>();
		List<Object> valueList = new ArrayList<Object>();
		
		resultList = (List)service.getQuestionList(paramMap);
		colList = (List)service.getEaxmColList(paramMap);
		rowList = (List)service.getExamRowList(paramMap);
		valueList = (List)service.getExamValueList(paramMap);
		
		
		resultMap.put("data", resultList);
		resultMap.put("col", colList);
		resultMap.put("row", rowList);
		resultMap.put("val", valueList);
		
		return resultMap;
		
	}
	
	@RequestMapping(value ="/responseAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Object> responseAjax(@RequestParam Map<String, Object> paramMap) {
		
		System.out.println("response");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Object> colList = new ArrayList<Object>();
		List<Object> rowList = new ArrayList<Object>();
		List<Object> questionList = new ArrayList<Object>();
		
		colList = (List)service.getResponseColList(paramMap);
		rowList = (List)service.getResponseRowList(paramMap);
		questionList = (List)service.getQuestionList(paramMap);
		
		resultMap.put("col", colList);
		resultMap.put("row", rowList);
		resultMap.put("data", questionList);
		
		return resultMap;
		
	}
	
	@RequestMapping(value ="/crossResponseAjax", method = { RequestMethod.GET, RequestMethod.POST })
	public @ResponseBody Map<String, Object> crossResponseAjax(@RequestParam Map<String, Object> paramMap) {
		
		System.out.println("response2");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Object> colList = new ArrayList<Object>();
		List<Object> rowList = new ArrayList<Object>();
		List<Object> valList = new ArrayList<Object>();
		
		colList = (List)service.getCrossColList(paramMap);
		rowList = (List)service.getCrossRowList(paramMap);
		valList = (List)service.getCrossValList(paramMap);
		
		resultMap.put("col", colList);
		resultMap.put("row", rowList);
		resultMap.put("val", valList);
		
		return resultMap;
		
	}
	
}
