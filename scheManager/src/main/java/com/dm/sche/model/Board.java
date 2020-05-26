package com.dm.sche.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 게시판
 * @author mijung
 *
 */

@Data
@Alias("board")
public class Board {

	private Integer boardIdx;					// 게시판 PK
	private Integer boardManagerIdx;			// 게시판 관리 PK
	private Integer createMemberIdx;			// 작성자 PK
	private Integer updateMemberIdx;			// 수정자 PK
	private String boardType;					// 게시판 타입(1: 일반, 2: 공지사항, 3: 파일게시판 등등)
	private String boardTitle;					// 제목
	private String boardContent;				// 내용
	private String boardSeq;					// 게시판번호 (게시판 추가시 구분자가 될 번호) + (번호 채번 필요 ex)BOR100, BOR101, BOR102 ...)
	private long hit;							// 조회수
	private String isPopup;						// 팝업여부(Y: 사용, N: 미사용)
	private String isPopupShow;					// 팝업 노출 여부 (Y: 사용, N: 미사용)
	private String popupWidth;					// 팝업 가로 사이즈
	private String popupHeight;					// 팝업 세로 사이즈
	private String popupLeft;					// 팝업 x축 위치
	private String popupTop;					// 팝업 y축 위치
	private Date popupStartDate;				// 팝업 시작일
	private Date popupEndDate;					// 팝업 종료일
	private Date createDate;					// 작성일
	private Date updateDate;					// 수정일

	private String memberName;					// 작성자
	
}
