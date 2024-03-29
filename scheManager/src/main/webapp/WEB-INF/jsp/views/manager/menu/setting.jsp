<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
	<link rel="stylesheet" href="/css/views/menuSetting.css">
</head>

<script type="text/javascript">
var setMenu;
var mergeList = [];

var csrfToken = '${_csrf.token}';
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken;

$(function(){
	
	$(".disabled").show();

	var checkedTag;
	
	setMenu = new Vue({
		
		el 		: "#setMenu",
		
		data 	: {
			menuList : [],
		},
		
		methods : {
			
			// 메뉴 리스트 호출
			getList : function (){
				
				// promise
				axios.post('/mainMenu/menuList').then(response => {

					if ( response.status == 200 ){
						
						$.each(response.data.menuList, function () {
							
							var subMenuList = this.subMenuList;
							var isSub = false;

							// 서브메뉴 목록
							$.each(subMenuList, function (s, sItem){
								
								// 서브메뉴 Idx 가 있을 때에만 하위 메뉴 생성
								if ( this.subMenuIdx ){
									isSub = true;
								}

							});
							
							this.isSub = isSub;
							
						});
						
						setMenu.menuList = response.data.menuList;
						
					}
					
				});
				
			},

			changeMenuLi : function (thisTag){

				var thisParent = $(thisTag).parent();
				var saveType = "";
				
				var btnGrp  = '<div class="btnGrp display_ib">';
					btnGrp += '    <button type="button" class="btn btn-default btn-xs mgnr5" id="btnUp">▲</a>';
					btnGrp += '    <button type="button" class="btn btn-default btn-xs mgnr5" id="btnDown">▼</a>';
					btnGrp += '    <button type="button" class="btn btn-danger btn-xs"  id="btnDel"><i class="fa fa-trash-o"></i></a>';
					btnGrp += '</div>';
				
				var isActive = $('li[isActive=Y]');
					
				// 모든 active 속성 초기화
				if ( $(isActive) ){
					
					$(isActive).css({"background-color" :  "#fff", "font-weight" : "normal"});
					$('.btnGrp').remove();
					
					$(isActive).attr("isActive", "N");
				}
				
				// 현재 클릭 한 요소에 active 속성 적용
				if ( thisParent.attr("isActive") == "N" ){
					thisParent.css({"background-color" : "#eee", "font-weight" : "bold"}).append(btnGrp).attr("isActive", "Y");
				}
				
				// 서브 메뉴 중 최상위에 있을 떄 ▲ 버튼 제거
				var isFirstMenu = thisParent.prev().length;
				if ( isFirstMenu == 0 ){
					$('#btnUp').attr("disabled", "false");
				}

				// 서브 메뉴 중 최하위에 있을 때 ▼ 버튼 제거
				var isLastMenu = thisParent.next().length;
				if ( isLastMenu == 0 ){
					$('#btnDown').attr("disabled", "false");
				}

				// ▲ 버튼 클릭 이벤트
				$("#btnUp").unbind("click").click(function(){
					thisParent.after(thisParent.prev());
					
				});
				
				// ▼ 버튼 클릭 이벤트
				$("#btnDown").unbind("click").click(function(){
					thisParent.before(thisParent.next());
				});
				
				// 삭제 버튼 클릭 이벤트
				$("#btnDel").unbind("click").click(function(){
					
					if ( confirm("선택 한 메뉴를 삭제 하시겠습니까?\n저장을 누르면 완료됩니다.") ){
						
						thisParent.attr("isUse", "N");
						thisParent.hide();
						
					} else {
						return false;
					}
					
				});

			},

			// 저장 버튼 이벤트
			save : function (saveType){
				
				var params = new URLSearchParams();
				
				if ( confirm("저장 하시겠습니까?") ){
					
					if ( saveType == "U" ){
						
						var mainMenuList = $(".menuUl").find("li");
						
						var subMenuList = mainMenuList.children(".subMenuUl");
						var subSeqArr   = [];
						var subIdxArr   = [];
						var isUseArr	= [];
						
						var mainMenuLength = mainMenuList.length;
						
						for ( var i = 0; i < mainMenuLength; i++ ){
							
							var subLi = $(mainMenuList[i]).find(".subMenuUl").find("li");
							var subLiLength = subLi.length;
							
							for ( var s = 0; s < subLiLength; s++ ){
								
								$(subLi[s]).attr("subseq", (s + 1));
								
								subSeqArr.push($(subLi[s]).attr("subSeq"));
								subIdxArr.push($(subLi[s]).attr("subIdx"));
								isUseArr.push($(subLi[s]).attr("isUse"));
								
							}
							
						}

						params.append("type", 		saveType);			// 저장 타입
						params.append("subSeqArr", 	subSeqArr);			// 순서 Array
						params.append("subIdxArr", 	subIdxArr);			// Idx Array
						params.append("isUseArr", 	isUseArr);			// 사용 여부 Array
						
						axios.post('/mainMenu/merge', params).then(response => {
							
							if ( response.status == 200 ){
								
								alert("저장 되었습니다.");
								getMenuSetting();		// 좌측 메뉴 reload
								location.reload();		// 페이지 reload
								
							} else {
								
								alert("저장에 실패 하였습니다.");
								return false;
								
							}
							
						});
						
					} else {
						return false;
					}
				}
				
			},
			
			// 상세
			detail : function ( event, subMenuIdx ){
				
				var parentTag	= $(event.target).parent().parent();
				var parentIdx	= parentTag.parent().attr("idx");
				
				var menuName 	= $(".menuName");					// 하위 메뉴 명
				var menuComment = $(".menuComment");				// 하위 메뉴 설명
				var detailTitle = $(".detailTitle");				// 하위 메뉴 설정 제목
				var updateBtn   = $(".update");						// 업데이트 버튼
				
				var params = new URLSearchParams();
				params.append("subMenuIdx",  subMenuIdx);
				params.append("menuName",	 menuName.val());
				params.append("comment", 	 menuComment.val());
				
				axios.post('/mainMenu/detail', params).then(response => {
					
					if ( response.status == 200 ){
						
						var detail = response.data.detail;
						
						$(".subMenuTitle").text("상세");
						$(".disabled").fadeOut();
						$(".subIdx").val(subMenuIdx);
						
					} else {
						
						alert("서버 에러");
						return false;
						
					}
					
					// 메뉴명, 메뉴메모, 사용여부 disabled
					menuName.attr("readOnly", true);
					menuComment.attr("readOnly", true);
					$("input[name='optionsRadios']").attr("disabled", true);
					
					// 일정관리 일 경우 [수정] 버튼 show
					if ( parentIdx == 2 ){
						
						updateBtn.show();
						detailTitle.text("일정관리");
						
					// 일정관리 외의 메뉴 일 경우 [수정] 버튼 hide
					} else {
						
						updateBtn.hide();
						detailTitle.text(parentTag.parent().find(".mainMenuName").text());
						
					}
					
					menuName.val(detail.menuName);																// 하위 메뉴 명
					$(".menuSeq").text(detail.subMenuSeq);														// 하위 메뉴 순서
					$(".createDate").text(converter.date.basic.toString(detail.createDate, "/"));				// 하위 메뉴 생성일
					$(".updateDate").text(converter.date.basic.toString(detail.updateDate, "/"));				// 하위 메뉴 수정일
					$("input:radio[name='optionsRadios'][value=" + detail.isUse + "]").prop("checked", true);	// 사용여부
					menuComment.val(detail.comment);															// 하위 메뉴 설명
					
				});
				
			},
			
			// 하위 메뉴 수정
			update : function (event){
				
				var menuName 	= $(".menuName");				// 하위 메뉴 명
				var menuComment = $(".menuComment");			// 하위 메뉴 설명
				
				$(event.target).hide();
				
				menuName.attr("readOnly", false);
				menuComment.attr("readOnly", false);
				$(".radio").find("input").attr("disabled", false);
				$(".subMenuTitle").text("수정");
				
				$(".updateDate").text(converter.date.basic.toString(new Date(), "/"));
				
				// 수정 후 저장 버튼 이벤트
				$("#updateSave").unbind("click").click(function(){
					
					if ( !menuName.val() ){
						
						alert("메뉴명을 입력하세요.");
						menuName.focus();
						
						return false;
						
					}
					
					if ( confirm("저장 하시겠습니까?") ){
						
						var params = new URLSearchParams();
						params.append("subMenuIdx",  $(".subIdx").val());
						params.append("menuName", 	 menuName.val());
						params.append("comment", 	 menuComment.val());
						params.append("isUse",		 $(".radio").find("input[name='optionsRadios']:checked").val());
						
						// promise
						axios.post('/mainMenu/update', params).then(response => {
							
							if ( response.status == 200 ){
								
								alert("저장 되었습니다.");
								
								getMenuSetting();		// 좌측 메뉴 reload
								location.reload();		// 페이지 reload
								
							} else {
								
								alert("저장에 실패 하였습니다.");
								return false;
								
							}
							
						});
						
					} else {
						return false;
					}
					
				});
				
			},
			
			// 메뉴 등록 말풍선 mouseover 이벤트
			questionOver : function (){
				$(".question-info").fadeIn();
			},
			
			// 메뉴 등록 말풍선 mouseout 이벤트
			questionOut : function (){
				$(".question-info").fadeOut();
			},
			
			// 메뉴 추가 버튼 클릭 시 순서, 생성일 셋팅
			menuAdd : function ( event ){
				$(".disabled").fadeOut();
				
				var thisTarget = $(event.target);
				var parentUl = thisTarget.parent().parent();
				
				var menuName 	= $(".menuName");			// 하위 메뉴 명
				var menuComment = $(".menuComment");		// 하위 메뉴 설명
				var isUseRdo 	= $(".radio").find("input");
				
				$(".subMenuTitle").text("등록");
				$(".detailTitle").text(parentUl.find(".mainMenuName").text().replace("메뉴 추가", ""));
				menuName.val("");
				isUseRdo.eq(0).prop("checked", true);
				menuComment.val("");
				$(".subIdx").val("");
				$(".menuSeq").text("");
				$(".createDate").text("");
				$(".updateDate").text("");
				

				saveType = "I";

				
				menuName.attr("readOnly", false);
				menuComment.attr("readOnly", false);
				isUseRdo.prop("disabled", false);
				
				// 순서
				var lastSeq = parentUl.find(".subMenuUl").find("li").last().attr("subSeq");
				$(".menuSeq").text( (Number(lastSeq)) ? Number(lastSeq) + 1 : 1 );
				
				// 생성일
				var today = converter.date.basic.toString(new Date(), "/");
				$(".createDate").text(today);
				
				$("#updateSave").unbind("click").click(function(){

					// 메뉴명 미입력 시
					if ( !menuName.val() ){
						
						alert("메뉴명을 입력하세요.");
						menuName.focus();
						
						return false;
						
					}
					
					if ( confirm("저장 하시겠습니까?") ){
						
						var params = new URLSearchParams();
						params.append("mainMenuIdx", 	thisTarget.attr('menuIdx'));
						params.append("subMenuIdx",  	$(".subIdx").val());
						params.append("subMenuSeq",	 	$(".menuSeq").text());
						params.append("type",		 	saveType);
						params.append("menuName", 	 	menuName.val());
						params.append("comment", 	 	menuComment.val());
						params.append("isUse",		 	$(".radio").find("input[name='optionsRadios']:checked").val());
						
						axios.post('/mainMenu/merge', params).then(response => {
							
							if ( response.status == 200 ){
								
								alert("저장 되었습니다.");
								getMenuSetting();		// 좌측 메뉴 reload
								location.reload();		// 페이지 reload
								
							} else {
								
								alert("저장에 실패 하였습니다.");
								return false;
								
							}
							
						});
						
					} else {
						return false;
					}
					
				});
			
			},
			
			// 취소 버튼 이벤트
			cancle : function (){
				
				$(".detailTitle").text("");
				$(".subMenuTitle").text("등록");
				$(".menuName").val("");
				$(".subIdx").val("");
				$(".menuSeq").text("");
				$(".createDate").text("");
				$(".updateDate").text("");
				$(".radio").find("input").eq(0).prop("checked", true);
				$(".menuComment").val("");
				
				$(".disabled").fadeIn();
				
			}
			
		},

	});
	
	setMenu.getList();

});

</script>

<div id="setMenu" class="col-lg-12" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
	<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 pd0 position_re mgnr10" id="style-3">
		<div class="custom-box tl height600 force-overflow">
			<div class="servicetitle">
				<h4 class="tc mgnt40">메뉴 관리</h4>
				<hr>
			</div>
			<div class="scrollbar" style="height: 460px; padding: 10px;">
				<ul class="menuUl">
					<li class="menuLi" v-for="(item, index) in menuList" v-bind:idx="item.mainMenuIdx" v-bind:seq="item.menuSeq">
						<i class="fa fa-folder"></i>
						<span class="mainMenuName" v-if="item.isAdd == 'N' ">&nbsp;{{ item.mainMenuName }}</span>
						<span class="mainMenuName" v-else-if="item.isAdd == 'Y' ">
							&nbsp;{{ item.mainMenuName }}
							<button type="button" class="btn btn-default btn-xs fr" @click="menuAdd($event)" v-bind:menuIdx="item.mainMenuIdx">메뉴 추가</button>
						</span>
						<ul class="subMenuUl mgnt10">
							<li v-for="(subItem, index) in item.subMenuList" 
								v-if="item.isSub" 
								v-bind:id="'subMenu_' + item.mainMenuIdx + '_' + subItem.subMenuIdx" 
								@click="changeMenuLi($event.target)"
								@dblclick="detail($event, subItem.subMenuIdx)"
								isActive="N"
								v-bind:subSeq="subItem.subMenuSeq"
								v-bind:subIdx="subItem.subMenuIdx"
								v-bind:isUse="subItem.isUse">
								　　<span class="subMenuName display_ib col-lg-8">{{ subItem.menuName }}</span>
							</li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="tc btn-wrap position_re">
				<button type="button" class="btn btn-primary" id="btnSave" @click="save('U')">저장</button>
			</div>

		</div>
		<!-- end custombox -->
	</div>

	<!-- DETAIL -->
	<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 pd0 position_re">
		<form action="#" class="form-horizontal style-form custom-box tl height600 col-lg-12">
			<div class="servicetitle">
				<h4 class="tc mgnt40">하위 메뉴 <span class="subMenuTitle">등록</span></h4>
				<hr>
			</div>
			<div class="formWrap">
				<div class="form-group">
					<strong class="control-label font-blue pdl10 detailTitle"></strong>
					<i class="fa fa-question-circle mgnl5" @mouseover="questionOver" @mouseout="questionOut"></i>
					<span class="font11 font-white mgnl5 question-info pd5">하위 메뉴 등록은 일정관리, 공지 & 게시 만 가능합니다.</span>
					<input type="hidden" class="subIdx" value="">
				</div>
				<div class="form-group">
					<label class="control-label display_ib width100"><span class="font-red">*</span> 메뉴명</label>
					<div class="width200 display_ib">
						<input class="form-control form-control-inline input-medium menuName display_ib" type="text" value="">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label display_ib width100">순서</label>
					<div class="height34 width200 display_in">
						<span class="menuSeq"></span>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label display_ib width100">생성일</label>
					<div class="height34 createDate width200 display_in"></div>
				</div>
				<div class="form-group">
					<label class="control-label display_ib width100">수정일</label>
					<div class="height34 updateDate width200 display_in"></div>
				</div>
				<div class="form-group">
					<label class="control-label display_ib width100">사용여부</label>
					<div class="radio height34 width200 pdl0 display_in lineHeight20">
						<label style="text-indent: 0">
							<input type="radio" name="optionsRadios" id="optionsRadios2" value="Y" checked>
							사용
						</label>
						<label style="text-indent: 0" class="mgnl10">
							<input type="radio" name="optionsRadios" id="" value="N">
							미사용
						</label>
					</div>
				</div>
				<div class="form-group border-bottom0">
					<label class="control-label display_ib width100 fl">메모</label>
					<div class="width200 display_ib">
						<textarea class="form-control input-medium menuComment display_ib fl" style="height: 56px !important;"></textarea>
					</div>
				</div>
			</div>
			<div class="tc btn-wrap">
				<button type="button" class="btn btn-default mgnr5" @click="cancle">취소</button>
				<button type="button" class="btn btn-primary mgnr5 update" style="display: none;" @click="update($event)">수정</button>
				<button type="button" class="btn btn-primary" id="updateSave">저장</button>
			</div>
		</form>
		
		<!-- Menu Disabled -->
		<div class="position_ab height600 layer_disabled menu_disabled disabled" style="width: 100%;">
			<div class="position_ab disabled" style="display: none; top: 44%;  width: 100%;">
				<b class="font-white font_shadow2 font15 position_ab tc" style="width: 100%; ">메뉴 추가 버튼을 클릭하여 주시기 바랍니다.</b>
			</div>
		</div>
		
		<!-- end custombox -->
	</div>
	
</div>
