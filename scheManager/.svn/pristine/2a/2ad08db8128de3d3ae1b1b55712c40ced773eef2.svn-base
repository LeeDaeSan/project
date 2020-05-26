package com.dm.sche.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.dm.sche.dto.MenuDTO;
import com.dm.sche.model.SubMenu;

@Service
public interface MainMenuService {

	/**
	 * 
	 * @param request
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 7. 30.
	 * @Comment : 메인 메뉴 리스트 조회
	 *
	 */
	public Map<String, Object> select(HttpServletRequest request);
	
	/**
	 * 
	 * @param subMenuIdx
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 7. 30.
	 * @Comment : 하위메뉴 상세 조회 
	 *
	 */
	public Map<String, Object> detail(int subMenuIdx);
	
	/**
	 * 
	 * @param menuDTO
	 * @param subMenu
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 7. 30.
	 * @Comment : 일정관리 - 하위 메뉴 등록, 순서 수정, 삭제
	 *
	 */
	public Map<String, Object> merge (MenuDTO menuDTO, SubMenu subMenu);

	/**
	 * 
	 * @param subMenu
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 7. 31.
	 * @Comment : 일정관리 - 하위 메뉴 수정
	 *
	 */
	public Map<String, Object> update(SubMenu subMenu);
	
}
