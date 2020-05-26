package com.dm.sche.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 폰트 색상 정보 - 캘린더 전용
 * @author mijung
 *
 */

@Data
@Alias("fontColor")
public class FontColor {

	private Integer fontColorIdx;		// 색상 정보
	private String fontColor;			// 폰트 색상
	private String bgColor;				// 배경 색상
	private String nameKor;				// 한글명
	private String nameEng;				// 영문명
	private String isUse;				// 사용여부(Y: 사용, N: 미사용)
	private Date createDate;			// 생성일
	
}
