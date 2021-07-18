package com.ds.home.model;
import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * 사용자 개인 부동산 정보 Table
 * 
 * @author daesan
 *
 */
@Data
@Alias("memberRealEstate")
public class MemberRealEstate {

	private Integer memberRealEstateIdx;
	private Integer memberIdx;
	private String houseName;
	private String address;
	private String stationLine;
	private String stationName;
	private String stationRange;
	private Date useApproveDate;
	private String totalHouseholdCount;
	private String parkingPossibleCount;
	private String directionType;
	private String bay;
	private String supplySpace;
	private String exclusiveSpace;
	private String dealType;
	private Long dealPrice;
	private Long brokerFee;
	private Long acquisitionTax;
	private Long propertyTotalTax;
	private String remark;
	private Date createDate;
	private Date updateDate;
	
	private String useApproveDateStr;
	/**
	 * 사용자 정보
	 */
	private Member member;
}
