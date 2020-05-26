package com.dm.sche.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dm.sche.constant.Constant;
import com.dm.sche.constant.UserConstant;
import com.dm.sche.dto.KeywordDTO;
import com.dm.sche.dto.PagingDTO;
import com.dm.sche.mapper.HouseHoldItemDetailMapper;
import com.dm.sche.mapper.HouseHoldItemMapper;
import com.dm.sche.mapper.MemberHoldItemMapper;
import com.dm.sche.model.HouseHoldItem;
import com.dm.sche.service.HouseHoldItemService;
import com.dm.sche.util.ResponseUtil;

@Service
public class HouseHoldItemServiceImpl implements HouseHoldItemService {

	@Autowired
	private HouseHoldItemMapper houseHoldItemMapper;
	@Autowired
	private MemberHoldItemMapper memberHoldItemMapper;
	@Autowired
	private HouseHoldItemDetailMapper houseHoldItemDetailMapper;
	
	/**
	 * 대분류 항목 정보 조회
	 */
	@Override
	public Map<String, Object> select(PagingDTO<HouseHoldItem> pagingDTO) {

		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", 		houseHoldItemMapper.select(pagingDTO));
			resultMap.put("totalcount", houseHoldItemMapper.selectForTotalcount(pagingDTO));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		return resultMap;
	}

	/**
	 * 마지막 코드번호 조회
	 */
	@Override
	public Map<String, Object> selectOfNextCode(HouseHoldItem houseHoldItem) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("maxCode", houseHoldItemMapper.selectOfNextCode(houseHoldItem));
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		return resultMap;
	}
	
	/**
	 * 대분류 항목 상세 정보 조회
	 */
	@Override
	public Map<String, Object> detail(int itemIdx) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("detail", houseHoldItemMapper.detail(itemIdx));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	/**
	 * 대분류 항목 정보 등록, 수정, 삭제
	 */
	@Override
	@Transactional
	public Map<String, Object> merge (String type, HouseHoldItem houseHoldItem) {
		
		Map<String, Object> resultMap = null;
		Integer result = -1;
		try {
			resultMap = ResponseUtil.successMap();
			
			int memberIdx = UserConstant.getUser().getIdx();
			
			// insert
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				houseHoldItem.setCreateMemberIdx(memberIdx);
				result = houseHoldItemMapper.insert(houseHoldItem);
				
			// update
			} else if (Constant.MERGE_TYPE_UPDATE.equals(type)) {
				houseHoldItem.setUpdateMemberIdx(memberIdx);
				result = houseHoldItemMapper.update(houseHoldItem);
				
			// delete
			} else if (Constant.MERGE_TYPE_DELETE.equals(type)) {

				// 가계 코드 사용중인 사용자 확인
				Long memberCount = memberHoldItemMapper.memberHoldItemOfCount(houseHoldItem.getItemIdx());
				if (memberCount > 0) {
					result = -2;
				}
				
				// 가계 코드 상세가 있는지 확인
				if (result == -1) {
					Long houseHoldItemDetailCount = houseHoldItemDetailMapper.houseHoldItemDetailOfCount(houseHoldItem.getItemIdx());
					if (houseHoldItemDetailCount > 0) {
						result = -3;
					}
				}
				
				if (result == -1) {
					result = houseHoldItemMapper.delete(houseHoldItem.getItemIdx());
				}
			}
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		resultMap.put("resultCnt", result);
		
		return resultMap;
	}
	
	/**
	 * 대분류 등록, 수정시 중복확인
	 */
	@Override
	public String keywordCheck(KeywordDTO keywordDTO) {
		return houseHoldItemMapper.keywordCheck(keywordDTO);
	}
	
	/**
	 * 가계 등록시 조회되는 대분류 항목 목록
	 */
	@Override
	public Map<String, Object> selectOfPopup(PagingDTO<HouseHoldItem> pagingDTO) {
		
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", houseHoldItemMapper.selectOfPopup(pagingDTO));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	/**
	 * 가계 코드기준 통계 목록
	 */
	@Override
	public Map<String, Object> selectOfStatistics(PagingDTO<HouseHoldItem> pagingDTO) {
		
		Map<String, Object> resultMap = null;
		
		try {
			int memberIdx = UserConstant.getUser().getIdx();
			pagingDTO.setMemberIdx(memberIdx);
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("level1List", houseHoldItemMapper.selectOfStatistics(pagingDTO));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		}
		
		return resultMap;
	}
}
