package com.dm.sche.util;

import org.springframework.util.StringUtils;

public class StringUtil {

	/**
	 * 공백이거나 null인 경우 true
	 * @param obj
	 * @return
	 */
	public static boolean isEmpty (Object obj) {
		
		if (StringUtils.isEmpty(obj)) {
			return true;
		}
		
		return false;
	}
	
	/**
	 * 공백이 아니고 null이 아닐 경우 true
	 * @param obj
	 * @return
	 */
	public static boolean isNotEmpty (Object obj) {
		
		if (!StringUtils.isEmpty(obj)) {
			return true;
		}
		
		return false;
	}
	
	/**
	 * 문자열 split
	 * @param str
	 * @param pattern
	 * @return
	 */
	public static String [] split (String str, String pattern) {
		if (isEmpty(str) || isEmpty(pattern)) {
			return null;
		}
		
		return str.split(pattern);
	}
	
	/**
	 * Object to String 
	 * 
	 * @param obj
	 * @return
	 */
	public static String toString (Object obj) {
		
		if (isEmpty(obj)) {
			return "";
		}
		
		return obj.toString();
	}
}
