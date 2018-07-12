package com.seoulmode.lecture.controller;

import java.util.HashMap;
import java.util.Map;

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
   public Object actionMethod(@RequestParam Map<String, Object> paramMap, @PathVariable String action) {
	   
	   Map resultMap = new HashMap();
         
   return resultMap;
      
   }
}