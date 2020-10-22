package com.ds.homes.model.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.AccountBook;
import com.ds.homes.model.dto.AccountBookDTO;
import com.ds.homes.model.dto.PagingDTO;
import com.ds.homes.model.mapper.AccountBookMapper;
import com.ds.homes.model.mapper.CalculateMapper;
import com.ds.homes.model.service.AccountBookService;
import com.ds.homes.tools.constant.Constant;
import com.ds.homes.tools.constant.UserConstant;
import com.ds.homes.tools.util.DateUtil;
import com.ds.homes.tools.util.ResponseUtil;

@Service
public class AccountBookServiceImpl implements AccountBookService {

	@Autowired
	private AccountBookMapper accountBookMapper;
	@Autowired
	private CalculateMapper calculateMapper;
	
	@Override
	public Map<String, Object> select(PagingDTO<AccountBook> pagingDTO) {
		Map<String, Object> resultMap = null;
		
		try {
			Integer homeIdx = UserConstant.getUser().getHomeIdx();
			AccountBook accountBook = pagingDTO.getModel();
			accountBook.setHomeIdx(homeIdx);
			pagingDTO.setModel(accountBook);
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("list", accountBookMapper.select(pagingDTO));
		} catch (Exception e) {
			e.printStackTrace();
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> merge(AccountBookDTO accountBookDTO, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			Integer result = 1;
			
			Integer homeIdx = UserConstant.getUser().getHomeIdx();
			
			// 등록
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				List<AccountBook> list = accountBookDTO.getAccountBookList();
				Integer listLength = list.size();
				
				for (int i = 0; i < listLength; i++) {
					AccountBook accountBook = list.get(i);
					
					accountBook.setHomeIdx(homeIdx);
					accountBook.setAccountDate(DateUtil.stringToDate(accountBook.getAccountDateStr(), "yyyy-MM-dd"));
					
					if (result == 1) {
						result = accountBookMapper.insert(accountBook);
					} else {
						
					}
				}
				
			} else if (Constant.MERGE_TYPE_DELETE.equals(type)) {
				
				result = accountBookMapper.delete(accountBookDTO.getAccountBookIdx());
			}
			
			resultMap.put("result", result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> calculateList(AccountBook accountBook) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			
			accountBook.setHomeIdx(UserConstant.getUser().getHomeIdx());
			
			List<AccountBook> accountBookList = calculateMapper.select(accountBook);
			
			double inTotalAmount 	= 0;
			double outTotalAmount	= 0;
			for (AccountBook detail : accountBookList) {
				// 지출
				if (detail.getAccountCategory1().getCategoryIdx() == 1) {
					outTotalAmount += detail.getAmount();
				} else {
					inTotalAmount += detail.getAmount();
				}
			}
			
			resultMap.put("list"			, accountBookList);
			resultMap.put("inTotalAmount"	, inTotalAmount);
			resultMap.put("outTotalAmount"	, outTotalAmount);
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
}
