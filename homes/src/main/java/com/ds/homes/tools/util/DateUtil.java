package com.ds.homes.tools.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	/**
	 * String 날짜를 Date로 형변환
	 * @param dateStr
	 * @param pattern
	 * @return
	 */
	public static Date stringToDate (String dateStr, String pattern) {

		Date date = new Date();
		
		try {
			SimpleDateFormat format = new SimpleDateFormat(pattern + "hh:mm:ss");
			
			date = format.parse(dateStr + "09:00:00");
			
		} catch (ParseException e) {
		}
		
		return date;
	}
}
