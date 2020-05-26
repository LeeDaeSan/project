package com.dm.sche.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dm.sche.model.MainMenu;
import com.dm.sche.model.SubMenu;

@Mapper
public interface MainMenuMapper {

	/**
	 * 
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 7. 30.
	 * @Comment :메인 메뉴 리스트 조회
	 * 
	 */
	public List<MainMenu> select(int memberIdx);

	/**
	 * 
	 * @param subMenuIdx
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 7. 30.
	 * @Comment : 하위 메뉴 상세 조회 
	 * 
	 */
	public SubMenu detail(int subMenuIdx);	

	/**
	 * 
	 * @param subMenu
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 7. 30.
	 * @Comment : 일정관리 - 하위 메뉴 등록
	 * 
	 */
	public Integer insert(SubMenu subMenu);
	
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
	public Integer update(SubMenu subMenu);
	
	/**
	 * 
	 * @param subMenu
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 7. 30.
	 * @Comment : 하위 메뉴 순서 변경
	 * 
	 */
	public Integer updateForSeq(SubMenu subMenu);
	
	/**
	 * 
	 * @param subMenu
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 7. 30.
	 * @Comment : 일정관리 - 하위메뉴 삭제
	 *
	 */
	public Integer delete(SubMenu subMenu);
	
}
