package com.seoulmode.lecture.component;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;


public class CustomizaMethodArgumentResolver implements HandlerMethodArgumentResolver {
	

	@Override
	public boolean supportsParameter(MethodParameter methodParameter) {
		
		return MapParamCollector.class.isAssignableFrom(methodParameter.getParameterType());
	}

	@Override
	public Object resolveArgument(MethodParameter methodParameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		Class<?> clazz = methodParameter.getParameterType();
		MapParamCollector requestMap = new MapParamCollector();
		if(clazz.equals(MapParamCollector.class)) {
			HttpServletRequest request = (HttpServletRequest)webRequest.getNativeRequest();
			Enumeration<?> enumeration = request.getParameterNames();
			while(enumeration.hasMoreElements()) {
				String key = (String)enumeration.nextElement();
				String[] values = request.getParameterValues(key);
				if(values != null) {
					requestMap.put(key,(values.length >1)? values:values[0]);}
				}
		}
		return requestMap;
	}

}