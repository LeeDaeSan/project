package com.ds.homes.model.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.CheckMemo;
import com.ds.homes.model.dto.CheckMemoDTO;
import com.ds.homes.model.mapper.CheckMemoMapper;
import com.ds.homes.model.service.CheckMemoService;
import com.ds.homes.tools.constant.UserConstant;
import com.ds.homes.tools.util.ResponseUtil;

@Service
public class CheckMemoServiceImpl implements CheckMemoService {
	
	@Autowired
	private CheckMemoMapper checkMemoMapper;
	
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
	public Map<String, Object> merge(CheckMemoDTO checkMemoDTO, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			Integer result = 0;
			for (CheckMemo checkMemo : checkMemoDTO.getCheckMemoList()) {
				checkMemo.setHomeIdx(UserConstant.getUser().getHomeIdx());
				
				// 등록
				if (checkMemo.getCheckMemoIdx() == 0) {
					result = checkMemoMapper.insert(checkMemo);
					
				// 수정
				} else {
					result = checkMemoMapper.update(checkMemo);
				}
			}
					
			resultMap = ResponseUtil.successMap();
			resultMap.put("result", result);
			
		} catch (Exception e) {
			e.printStackTrace();
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> isChecked(CheckMemo checkMemo) {
		Map<String, Object> resultMap = null;
		
		try {
			checkMemo.setHomeIdx(UserConstant.getUser().getHomeIdx());
			
			Integer result = checkMemoMapper.update(checkMemo);
			
			if (result == 1) {
				resultMap = ResponseUtil.successMap();
			} else {
				resultMap = ResponseUtil.failureMap();
			}
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		return resultMap;
	}
	
	@Override
	public Map<String, Object> delete(Integer checkMemoIdx) {
		Map<String, Object> resultMap = null;
		
		try {
			Integer result = checkMemoMapper.delete(checkMemoIdx);
			
			if (result == 1) {
				resultMap = ResponseUtil.successMap();
			} else {
				resultMap = ResponseUtil.failureMap();
			}
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
}
