package com.homes.ds.contoller.rest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.homes.ds.dto.BankBookDetailDTO;
import com.homes.ds.dto.PagingDTO;
import com.homes.ds.model.BankBookDetail;
import com.homes.ds.service.BankBookDetailService;

@RestController
@RequestMapping("/rest/bankBookDetail")
public class BankBookDetailRestController {

	@Autowired
	private BankBookDetailService bankBookDetailService;
	
	/**
	 * 가계 상세 정보 목록 조회 Controller
	 * 
	 * @param bankBookDetail
	 * @return
	 */
	@PostMapping("/list")
	public Map<String, Object> list (PagingDTO<BankBookDetail> pagingDTO, BankBookDetail bankBookDetail) {
		pagingDTO.setModel(bankBookDetail);
		return bankBookDetailService.list(pagingDTO);
	}
	
	/**
	 * 가계 상세의 상세 정보 조회 Controller
	 * 
	 * @param bankBookDetail
	 * @return
	 */
	@PostMapping("/detail")
	public Map<String, Object> detail (BankBookDetail bankBookDetail) {
		return bankBookDetailService.detail(bankBookDetail.getBankBookDetailIdx());
	}
	
	/**
	 * 가계 상세 정보 저장 Controller
	 *  -> 등록, 수정, 삭제 Batch
	 *  
	 * @param bankBookDetailDTO
	 * @param type
	 * @return
	 */
	@PostMapping("/change")
	public Map<String, Object> change (BankBookDetailDTO bankBookDetailDTO, @RequestParam(value = "type") String type) {
		return bankBookDetailService.change(bankBookDetailDTO, type); 
	}
}
