package com.dm.sche.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 부동산 참고 사이트
 * @author mijung
 *
 */

@Data
@Alias("eStateLink")
public class EStateLink {

	private Integer eStateLinkIdx;		// PK
	private String name;				// 사이트 명
	private String content;				// 상세 내용
	private String linkType;			// 사이트유형(1: 뉴스 신문, 2: 시장동향, 3: 정부, 4: 통계수치, 5: 매물정보, 6: 경매정보, 7: 임대료 공실정보, 8: 커뮤니티, 9: 칼럼 블로그 ...)
	private String url;					// URL 정보
	private String grade;				// 중요 등급
	private Date CreateDate;			// 생성일
	
}
