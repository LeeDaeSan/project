package com.ds.homes.tools.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

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
			SimpleDateFormat format = new SimpleDateFormat(pattern + "hh:mm:ss", Locale.KOREAN);
			
			date = format.parse(dateStr + "09:00:00");
			
		} catch (ParseException e) {
		}
		
		return date;
	}
	
	/**
	 * Date 날짜를 String으로 변환
	 * 
	 * @param d
	 * @param pattern
	 * @return
	 */
	public static String dateToString (Date d, String pattern) {
		String str = "";
		
		try {
			SimpleDateFormat transFormat = new SimpleDateFormat(pattern, Locale.KOREAN);

			str = transFormat.format(d);
		} catch (Exception e) {
		}
		
		return str;
	}
}
