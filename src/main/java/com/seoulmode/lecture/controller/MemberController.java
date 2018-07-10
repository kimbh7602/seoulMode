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
import com.seoulmode.lecture.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MemberController {
	private final static String MAPPING = "/member/";
	
	@Autowired
	private MemberService service;
	
	
	
	@RequestMapping(value = MAPPING+"{action}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView actionMethod(@RequestParam Map<String, Object> paramMap, @PathVariable String action,
			ModelAndView modelandView) {

		String viewName = MAPPING + action ;
		
		Map<String, Object> resultMap = new HashMap<String, Object>() ;
		List<Object> resultList = new ArrayList<Object>();

		if("list".equals(action)) {
			resultList = (List)service.getList(paramMap);
		}else if("read".equals(action)) {
			resultMap = (Map)service.getObject(paramMap);
		}else if("modify".equals(action)) {
			resultMap = (Map)service.readModify(paramMap);
		}else if("update".equals(action)) {
			service.updateObject(paramMap);
			resultList = (List)service.getList(paramMap);
			viewName = MAPPING + "list";
		}else if("delete".equals(action)) {
			service.deleteObject(paramMap);
			resultList = (List)service.getList(paramMap);
			viewName = MAPPING + "list";
		}else if("insert".equals(action)) {
			service.insertObject(paramMap);
			viewName = "/home";
		}
		
		
		modelandView.setViewName(viewName);

		modelandView.addObject("paramMap", paramMap);
		modelandView.addObject("resultMap", resultMap);
		modelandView.addObject("resultList", resultList);
		return modelandView;
	}
	
}
