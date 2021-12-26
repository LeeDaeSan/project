package com.dshome.system.etc.util;

import java.util.HashMap;
import java.util.Map;

public class ResponseUtil {
	
	public static Map<String, Object> successMap () {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status", 	true);
		resultMap.put("statusCode", "200");
		
		return resultMap;
	}
	
	public static Map<String, Object> failureMap () {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status", 	false);
		resultMap.put("statusCode", "400");
		
		return resultMap;
	}
}
