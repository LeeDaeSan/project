package com.ds.homes.model.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ds.homes.model.BankBook;
import com.ds.homes.model.BankBookDetail;
import com.ds.homes.model.dto.BankBookDetailDTO;
import com.ds.homes.model.dto.DashboardDTO;
import com.ds.homes.model.dto.PagingDTO;
import com.ds.homes.model.mapper.BankBookDetailMapper;
import com.ds.homes.model.mapper.BankBookMapper;
import com.ds.homes.model.mapper.CalculateMapper;
import com.ds.homes.model.mapper.DashboardMapper;
import com.ds.homes.model.service.BankBookDetailService;
import com.ds.homes.tools.constant.Constant;
import com.ds.homes.tools.constant.UserConstant;
import com.ds.homes.tools.util.DateUtil;
import com.ds.homes.tools.util.ResponseUtil;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BankBookDetailServiceImpl implements BankBookDetailService {
	
	@Autowired
	private BankBookDetailMapper bankBookDetailMapper;
	@Autowired
	private BankBookMapper bankBookMapper;
	@Autowired
	private CalculateMapper calculateMapper;
	@Autowired
	private DashboardMapper dashboardMapper;
	
	/**
	 * 가계 상세 정보 목록 조회
	 * 
	 */
	@Override
	public Map<String, Object> list(PagingDTO<BankBookDetail> pagingDTO) {
		Map<String, Object> resultMap = null;
		
		try {
			BankBookDetail detail = pagingDTO.getModel();
			detail.setHomeIdx(UserConstant.getUser().getHomeIdx());
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("bankBook"	, bankBookMapper.detail(detail.getBankBookIdx()));
			resultMap.put("list"		, bankBookDetailMapper.list(pagingDTO));
			resultMap.put("totalCount"	, bankBookDetailMapper.listForTotalCount(pagingDTO));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			log.error("{}", e);
		}
		
		return resultMap;
	}
	
	/**
	 * 가계 상세의 상세 정보 조회
	 */
	@Override
	public Map<String, Object> detail(Integer bankBookDetailIdx) {
		Map<String, Object> resultMap = null;
		
		try {
			resultMap = ResponseUtil.successMap();
			resultMap.put("detail", bankBookDetailMapper.detail(bankBookDetailIdx));
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			log.error("{}", e);
		}
		
		return resultMap;
	}
	
	/**
	 * 가계 상세 정보 등록
	 * 
	 */
	@Override
	public Map<String, Object> change(BankBookDetailDTO bankBookDetailDTO, String type) {
		Map<String, Object> resultMap = null;
		
		try {
			Integer result = 1;
			
			Integer homeIdx = UserConstant.getUser().getHomeIdx();
			
			// 등록
			if (Constant.MERGE_TYPE_INSERT.equals(type)) {
				List<BankBookDetail> list = bankBookDetailDTO.getBankBookDetailList();
				Integer listLength = list.size();
				
				// 가계 총 금액 조회하기
				BankBook bankBook = bankBookMapper.detail(list.get(0).getBankBookIdx());
				Double totalAmount = bankBook.getTotalAmount() == null ? 0 : bankBook.getTotalAmount();
				
				for (int i = 0; i < listLength; i++) {
					BankBookDetail detail = list.get(i);
					detail.setHomeIdx(homeIdx);
					detail.setAmountDate(DateUtil.stringToDate(detail.getAmountDateStr(), "yyyy-MM-dd"));
				
					// 입금인 경우
					if (Constant.BANKBOOK_AMOUNT_TYPE_IN.equals(detail.getAmountType())) {
						totalAmount += detail.getAmount();
						
					// 출금인 경우
					} else if (Constant.BANKBOOK_AMOUNT_TYPE_OUT.equals(detail.getAmountType())) {
						totalAmount -= detail.getAmount();
					}
					
					if (result == 1) {
						result = bankBookDetailMapper.insert(detail);
					} else {
						log.error("가계 정보 상세 등록 누락");
					}
				}
				
				// 가계 총 금액 수정
				if (result == 1) {
					bankBook.setBankBookIdx(list.get(0).getBankBookIdx());
					bankBook.setTotalAmount(totalAmount);
					
					result = bankBookMapper.updateForTotalAmount(bankBook);
				}
				
			// 수정
			} else if (Constant.MERGE_TYPE_UPDATE.equals(type)) {
				BankBookDetail befDetail = bankBookDetailDTO.getBefBankBookDetail();
				BankBookDetail aftDetail = bankBookDetailDTO.getAftBankBookDetail();
				
				// 가계 총 금액 조회하기
				BankBook bankBook = bankBookMapper.detail(aftDetail.getBankBookIdx());
				Double totalAmount = bankBook.getTotalAmount() == null ? 0 : bankBook.getTotalAmount();
				
				// 변경전 금액이 "입금"인 경우 출금으로 뺀다.
				if (Constant.BANKBOOK_AMOUNT_TYPE_IN.equals(befDetail.getAmountType())) {
					totalAmount -= befDetail.getAmount();
				// 변경전 금액이 "출금"인 경우 입금으로 더한다.
				} else if (Constant.BANKBOOK_AMOUNT_TYPE_OUT.equals(befDetail.getAmountType())) {
					totalAmount += befDetail.getAmount();
				}
				
				// 변경후 금액이 "입금"인 경우 입금으로 더한다.
				if (Constant.BANKBOOK_AMOUNT_TYPE_IN.equals(aftDetail.getAmountType())) {
					totalAmount += aftDetail.getAmount();
				// 변경후 금액이 "출금"인 경우 출금으로 뺀다.
				} else if (Constant.BANKBOOK_AMOUNT_TYPE_OUT.equals(aftDetail.getAmountType())) {
					totalAmount -= aftDetail.getAmount();
				}
				
				// 날짜 포맷
				aftDetail.setAmountDate(DateUtil.stringToDate(aftDetail.getAmountDateStr(), "yyyy-MM-dd"));
				
				// Mapper Call [가계 상세 수정]
				result = bankBookDetailMapper.update(aftDetail);

				// 가계정보 수정 (잔액 변경)
				if (result == 1) {
					bankBook.setTotalAmount(totalAmount);
					// Mapper Call [가계 잔액 수정]
					result = bankBookMapper.updateForTotalAmount(bankBook);
				} else {
					log.error("가계 잔액 변경 에러");
				}
				
			// 삭제
			} else if (Constant.MERGE_TYPE_DELETE.equals(type)) {
				List<BankBookDetail> list = bankBookDetailDTO.getBankBookDetailList();
				Integer listLength = list.size();
				
				// 가계 총 금액 조회하기
				BankBook bankBook = bankBookMapper.detail(list.get(0).getBankBookIdx());
				Double totalAmount = bankBook.getTotalAmount() == null ? 0 : bankBook.getTotalAmount();
				
				List<Integer> deleteList = new ArrayList<Integer>();
				for (int i = 0; i < listLength; i++) {
					BankBookDetail detail = list.get(i);
				
					// "입금"인 경우 출금으로 뺀다.
					if (Constant.BANKBOOK_AMOUNT_TYPE_IN.equals(detail.getAmountType())) {
						totalAmount -= detail.getAmount();
						
					// "출금"인 경우 입금으로 더한다
					} else if (Constant.BANKBOOK_AMOUNT_TYPE_OUT.equals(detail.getAmountType())) {
						totalAmount += detail.getAmount();
					}
					deleteList.add(detail.getBankBookDetailIdx());
				}
				
				// 삭제할 Idx 리스트
				bankBookDetailDTO.setDeleteList(deleteList);
				
				// Mapper Call [가계 정보 삭제]
				result = bankBookDetailMapper.delete(bankBookDetailDTO);
				
				// 가계정보 수정 (잔액 변경)
				if (result == 1) {
					bankBook.setTotalAmount(totalAmount);
					// Mapper Call [가계 잔액 수정]
					result = bankBookMapper.updateForTotalAmount(bankBook);
				} else {
					log.error("가계 잔액 변경 에러");
				}
			}
			
			resultMap = ResponseUtil.successMap();
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
			e.printStackTrace();
		} 
		
		return resultMap;
	}
	
	/**
	 * 정산 목록 조회
	 * 
	 */
	@Override
	public Map<String, Object> calculateList(BankBookDetail bankBookDetail) {
		Map<String, Object> resultMap = null;
		
		try {
			bankBookDetail.setHomeIdx(UserConstant.getUser().getHomeIdx());
//			
//			List<BankBookDetail> bankBookDetailList = calculateMapper.select(bankBookDetail);
//			
//			double inTotalAmount 	= 0;
//			double outTotalAmount 	= 0;
//			
//			// 총 수입 / 지출 금액 계산
//			for (BankBookDetail detail : bankBookDetailList) {
//				if ("IN".equals(detail.getAmountType())) {
//					inTotalAmount += detail.getAmount();
//				} else {
//					outTotalAmount += detail.getAmount();
//				}
//			}
//			
//			resultMap = ResponseUtil.successMap();
//			resultMap.put("list"			, bankBookDetailList);
//			resultMap.put("inTotalAmount"	, inTotalAmount);
//			resultMap.put("outTotalAmount"	, outTotalAmount);
//			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
	
	/**
	 * 정산 전 목록 조회 (정산 팝업)
	 * 
	 * @param bankBookDetail
	 * @return
	 */
	public Map<String, Object> befCalculateList (BankBookDetail bankBookDetail) {
		Map<String, Object> resultMap = null;
		
		try {
			bankBookDetail.setHomeIdx(UserConstant.getUser().getHomeIdx());
			
			List<DashboardDTO> dashboardList = dashboardMapper.selectChart(bankBookDetail);
			
			double inTotalAmount 	= 0;
			double outTotalAmount 	= 0;
			
			// 총 수입 / 지출 금액 계산
			for (DashboardDTO detail : dashboardList) {
				if ("IN".equals(detail.getAmountType())) {
					inTotalAmount += detail.getTotalAmount();
				} else {
					outTotalAmount += detail.getTotalAmount();
				}
			}
			
			resultMap = ResponseUtil.successMap();
			resultMap.put("list"			, dashboardList);
			resultMap.put("inTotalAmount"	, inTotalAmount);
			resultMap.put("outTotalAmount"	, outTotalAmount);
			resultMap.put("remainAmount"	, inTotalAmount - outTotalAmount);
			
		} catch (Exception e) {
			resultMap = ResponseUtil.failureMap();
		}
		
		return resultMap;
	}
}
