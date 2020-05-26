package com.dm.sche.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dm.sche.constant.Constant;
import com.dm.sche.constant.UserConstant;
import com.dm.sche.dto.PagingDTO;
import com.dm.sche.mapper.MemberHoldItemMapper;
import com.dm.sche.model.MemberHoldItem;
import com.dm.sche.service.MemberHoldItemService;
import com.dm.sche.util.DateUtil;
import com.dm.sche.util.ResponseUtil;

@Service
public class MemberHoldItemServiceImpl implements MemberHoldItemService {
	
	@Autowired
	private MemberHoldItemMapper memberHoldItemMapper;
	
	/**
	 * 사용자 가계 목록 조회
	 */
	@Override
	public Map<String, Object> select(String holdDateStr, PagingDTO<MemberHoldItem> pagingDTO) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			MemberHoldItem memberHoldItem = new MemberHoldItem();
			
			// 등록일 date format (String -> Date)
			memberHoldItem.setHoldDate(DateUtil.stringToDate(holdDateStr, "yyyy-MM-dd"));
			// session pk
			memberHoldItem.setMemberIdx(UserConstant.getUser().getIdx());
			
			pagingDTO.setModel(memberHoldItem);

			List<MemberHoldItem> memberHoldItemList = memberHoldItemMapper.select(pagingDTO);
			
			Double inAmount = 0d;
			Double outAmount = 0d;
			
			for (MemberHoldItem m : memberHoldItemList) {
				// 입금 금액
				if (Constant.HOLD_ITEM_TYPE_IN.equals(m.getType())) {
					inAmount += (double) m.getAmount();
					
				// 출금 금액
				} else if (Constant.HOLD_ITEM_TYPE_OUT.equals(m.getType())) {
					outAmount += (double) m.getAmount();
				}
			}
			
			resultMap.put("list"		, memberHoldItemList); 		// 목록
			resultMap.put("inAmount"	, inAmount);				// 입금 총액 
			resultMap.put("outAmount"	, outAmount);				// 출금 총액
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	/**
	 * 사용자 가계 등록, 수정, 삭제
	 */
	@Override
	public Map<String, Object> merge(String mergeType, String holdDateStr, MemberHoldItem memberHoldItem) {
		
		Map<String, Object> resultMap = null;
		Integer result = -1;
				
		try {
			resultMap = ResponseUtil.successMap();
			
			int memberIdx = UserConstant.getUser().getIdx();
			
			// 등록일 date format (String -> Date)
			memberHoldItem.setHoldDate(DateUtil.stringToDate(holdDateStr, "yyyy-MM-dd"));
			// session PK
			memberHoldItem.setMemberIdx(memberIdx);
			
			// insert
			if (Constant.MERGE_TYPE_INSERT.equals(mergeType)) {
				result = memberHoldItemMapper.insert(memberHoldItem);

			// delete
			} else if (Constant.MERGE_TYPE_DELETE.equals(mergeType)) {
				result = memberHoldItemMapper.delete(memberHoldItem);
			}

		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			
			e.printStackTrace();
		}
		
		resultMap.put("resultCnt", result);
		
		return resultMap;
	}

}
