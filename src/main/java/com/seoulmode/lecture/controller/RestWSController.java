package com.seoulmode.lecture.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.seoulmode.lecture.service.SurveyService;


@RestController
public class RestWSController {

   private final static String MAPPING = "/ws/";
   
   @Autowired
   private SurveyService surveyservice;
   
   @RequestMapping(value = MAPPING+"{action}",
   method = { RequestMethod.GET, RequestMethod.POST },produces = "application/json") // 미디어 타입 관련 응답 생성
   public Object actionMethod(@RequestParam Map<Object,Object> paramMap, @PathVariable String action,HttpServletRequest request) {
	   String[] parameterValues = request.getParameterValues("views");
	   paramMap.put("views",parameterValues);
	   String[] views_num = request.getParameterValues("views_num");
	   paramMap.put("views_num",views_num);
	   Map<Object,Object> resultMap = new HashMap<Object,Object>();
	   
		if("survey_insert".equals(action)) {
			String survey_seq =	(String) surveyservice.insertSurvey(paramMap);
			paramMap.put("SURVEY_SEQ",survey_seq);
			resultMap = (Map<Object, Object>) surveyservice.insertView(paramMap);
		}
         
   return resultMap;
      
   }
}