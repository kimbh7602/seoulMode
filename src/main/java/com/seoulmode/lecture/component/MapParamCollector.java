package com.seoulmode.lecture.component;

import java.util.HashMap;
import java.util.Map;

public class MapParamCollector {

	Map<Object,Object> map = new HashMap<Object,Object>();
	
	
	public Map<Object, Object> getMap(){
		return this.map;
	}
	
	
	public void put(String key, Object value) {
		this.map.put(key,value);
	}
}
