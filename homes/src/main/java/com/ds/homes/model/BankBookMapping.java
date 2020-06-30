package com.ds.homes.model;

import lombok.Data;

/**
 * 통장 맵핑 Table
 * 
 * @author idaesan
 *
 */
@Data
public class BankBookMapping {

	private Integer bankBookMappingIdx;
	private Integer memberIdx;
	private Integer bankBookIdx;
	private Integer homeIdx;
}
