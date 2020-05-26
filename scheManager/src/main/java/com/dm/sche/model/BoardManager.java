package com.dm.sche.model;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 공통 게시판
 * @author mijung
 *
 */

@Data
@Alias("boardManager")
public class BoardManager {

	private Integer boardManagerIdx;		// 게시판 관리 PK
	private String boardName;				// 게시판 명
	private String boardType;				// 게시판 타입
	private String remark;					// 비고
	private String isUse;					// 사용여부 (Y:사용, N:미사용)
	private Integer createMemberIdx;		// 생성자 PK
	private Integer updateMemberIdx;		// 수정자 PK
	private Date createDate;				// 생성일
	private Date updateDate;				// 수정일
	
	private String memberName;
	
}
