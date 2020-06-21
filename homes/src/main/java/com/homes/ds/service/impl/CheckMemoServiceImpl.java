package com.homes.ds.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homes.ds.constant.Constant;
import com.homes.ds.constant.UserConstant;
import com.homes.ds.mapper.CheckListMapper;
import com.homes.ds.mapper.CheckMemoMapper;
import com.homes.ds.model.CheckList;
import com.homes.ds.model.CheckMemo;
import com.homes.ds.service.CheckMemoService;
import com.homes.ds.util.ResponseUtil;

@Service
public class CheckMemoServiceImpl implements CheckMemoService {
	
	@Autowired
	private CheckMemoMapper checkMemoMapper;
	@Autowired
	private CheckListMapper checkListMapper;
	
	/**
	 * 체크 메모 정보 조회
	 */
	@Override
	public Map<String, Object> select(CheckMemo checkMemo) {
		Map<String, Object> resultMap = null;
		
		try {
			checkMemo.setHomeIdx(UserConstant.getUser().getHomeIdx());
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("info", checkMemoMapper.select(checkMemo));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	/**
	 * 체크 메모 정보 저장 Service
	 *  -> 등록, 수정
	 */
	@Override
	public Map<String, Object> merge(CheckMemo checkMemo, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			checkMemo.setHomeIdx(UserConstant.getUser().getHomeIdx());
					
			Integer result = 0;
			
			// 등록
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				result = checkMemoMapper.insert(checkMemo);
			// 수정
			} else if (Constant.MERGE_TYPE_UPDATE.equals(type)) {
				result = checkMemoMapper.update(checkMemo);
			}
			
			List<CheckList> checkList = checkMemo.getCheckList();
			int checkListSize = checkList.size();
			for (int i = 0; i < checkListSize; i++) {
				CheckList check = checkList.get(i);
				check.setCheckMemoIdx(checkMemo.getCheckMemoIdx());
				
				// 등록
				if (check.getCheckListIdx() == null || check.getCheckListIdx() == 0) {
					result = checkListMapper.insert(check);
					
				// 수정
				} else {
					result = checkListMapper.update(check);
				}
			}
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("result", result);
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	/**
	 * 체크리스트 check / uncheck update
	 */
	@Override
	public Map<String, Object> checked(CheckList checkList) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("result", checkListMapper.update(checkList));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	/**
	 * 체크리스트 수정, 삭제
	 * 
	 */
	@Override
	public Map<String, Object> merge(CheckList checkList, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			Integer result = 0;
			
			// 수정
			if (Constant.MERGE_TYPE_UPDATE.equals(type)) {
				result = checkListMapper.update(checkList);
				
			// 삭제
			} else if (Constant.MERGE_TYPE_DELETE.equals(type)) {
				result = checkListMapper.delete(checkList.getCheckListIdx());
			}
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("result", result);
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
}
