package com.ds.homes.model.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.BankBook;
import com.ds.homes.model.dto.PagingDTO;
import com.ds.homes.model.mapper.BankBookDetailMapper;
import com.ds.homes.model.mapper.BankBookMapper;
import com.ds.homes.model.service.BankBookService;
import com.ds.homes.tools.constant.Constant;
import com.ds.homes.tools.constant.UserConstant;
import com.ds.homes.tools.util.DateUtil;
import com.ds.homes.tools.util.ResponseUtil;
import com.ds.homes.tools.util.StringUtil;

@Service
public class BankBookServiceImpl implements BankBookService {
	
	@Autowired
	private BankBookMapper bankBookMapper;
	@Autowired
	private BankBookDetailMapper bankBookDetailMapper;
	
	/**
	 * 가계부 목록 조회
	 */
	@Override
	public Map<String, Object> list(PagingDTO<BankBook> pagingDTO) {
		
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list"		, bankBookMapper.list(pagingDTO));
			resultMap.put("totalCount"	, bankBookMapper.listOfTotalCount(pagingDTO));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	/**
	 * 가계 상세 정보 조회
	 */
	@Override
	public Map<String, Object> detail(Integer bankBookIdx) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("detail", bankBookMapper.detail(bankBookIdx));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}

	/**
	 * 가계부 저장
	 */
	@Override
	public Map<String, Object> merge(BankBook bankBook, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			Integer result = 0;
			
			// 등록
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				bankBook.setMemberIdx(UserConstant.getUser().getIdx());
				bankBook.setHomeIdx(UserConstant.getUser().getHomeIdx());
				bankBook.setOpenDate(DateUtil.stringToDate(bankBook.getOpenDateStr(), "yyyy-MM-dd"));
				
				if (StringUtil.isNotEmpty(bankBook.getCloseDateStr())) {
					bankBook.setCloseDate(DateUtil.stringToDate(bankBook.getCloseDateStr(), "yyyy-MM-dd"));
				}
				
				result = bankBookMapper.insert(bankBook);
				
			// 수정
			} else if (Constant.MERGE_TYPE_UPDATE.equals(type)) {
				bankBook.setOpenDate(DateUtil.stringToDate(bankBook.getOpenDateStr(), "yyyy-MM-dd"));
				if (StringUtil.isNotEmpty(bankBook.getCloseDateStr())) {
					bankBook.setCloseDate(DateUtil.stringToDate(bankBook.getCloseDateStr(), "yyyy-MM-dd"));
				}
				
				result = bankBookMapper.update(bankBook);
			
			// 삭제
			} else if (Constant.MERGE_TYPE_DELETE.equals(type)) {
				
				// 통장 내의 상세목록 삭제 Mapper 
				bankBookDetailMapper.deleteOfBankBook(bankBook.getBankBookIdx());
				// 통장 삭제 Mapper
				result = bankBookMapper.delete(bankBook.getBankBookIdx());
			}
			
			resultMap = ResponseUtil.successMap();				
			resultMap.put("result", result);
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	/**
	 * 메인통장 정보 조회
	 * 
	 */
	@Override
	public Map<String, Object> selectOfMainType(BankBook bankBook) {
		Map<String, Object> resultMap = null;
		
		try {
			Integer homeIdx = UserConstant.getUser().getHomeIdx();
			bankBook.setHomeIdx(homeIdx);
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("detail", bankBookMapper.selectOfMainType(bankBook));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		} 
		
		return resultMap;
		
	}
}
