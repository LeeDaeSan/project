<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

/* 상단 타이틀 영역 css */
.service-top {
	border-bottom	: 2px solid #e6e6e6;
    box-shadow		: 0px 1px 0px #efefef;
}
.service-top hr {
	border-top		: 3px solid #ff9d00;
	margin-top		: 0;
	margin-bottom	: 10px;
}
.service-top h4 {
	color : #020275;
}
/* 하단 버튼 영역 css */
.service-bottom {
	border-top		: 2px solid #e6e6e6;
    padding-top		: 10px;
    height			: 42px;
}

.menuUl .menuLi {
	padding			: 9px;
    border-bottom	: 1px solid #f1f1f1;
    font-size		: 14px;
    cursor			: pointer;
}
.menuUl .menuLi.hover:hover {
	background : #f7f7f7;
}
.menuUl .menuLi.active {
	background : #f1f1f1;
}
.menuUl .menuLi.active:hover {
	background : #e5e5e5;
}
.scrollbar {
	height		: 460px;
    padding		: 10px;
    overflow	: auto;
}
.remove_btn {
	position 	: relative;
	bottom		: 1px;
}
.holdItemLi .remove_btn {
	right		: -40px;
}
.holdItemDetailLi .remove_btn {
	right		: -78px;
}
.holdItemDetailLi2 .remove_btn {
	right		: -112px;
}
</style>
<script>
var oldItemCode;
var oldItemName;
var level1Idx;
var level2Idx;
var level1Obj;
var level2Obj;

$(function () {

	var setItem = new Vue({
		el 		: '#setItem',
		data 	: {
			level1List			: [],
			level2List			: [],
			level3List			: [],
			
			dataList 				: [],
			detailDataList			: [],
			isDeleteClick 			: false,
			isDeleteDetailClick 	: false,
			isDeleteDetailClick2 	: false,
		},
		methods : {
			
			list : function (level) {
				var thisApp = this;
				
				var params = new URLSearchParams();
				params.append('level', level);
				
				if (level == 2) {
					params.append('parentIdx', level1Idx ? level1Idx : 0);
				} else if (level == 3) {
					params.append('parentIdx', level2Idx ? level2Idx : 0);
				}
				
				// [필수설정]
				axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
				// Promise
				axios.post('/houseHoldItem/list', params).then(response => {
					
					if (response.status == 200) {
						var totalCount = response.data.totalcount;			// 조회된 전체 카운트

						// 대분류
						if (level == 1) {
							// 목록 정보
							setItem.level1List = response.data.list;
							// 카운팅 정보
							$('#houseHoldItemCount').text(totalCount);

							$('.code_add_btn:eq(1),.code_add_btn:eq(2)').hide();
							
						// 중분류
						} else if (level == 2) {
							
							// 목록 정보
							setItem.level2List = response.data.list;
							// 카운팅 정보
							$('#houseHoldItem2Count').text(totalCount);
							// button show / hide
							$('.code_add_btn:eq(1)').show();
							$('.code_add_btn:eq(2)').hide();
							
						// 소분류
						} else if (level == 3) {
							
							// 목록 정보
							setItem.level3List = response.data.list;
							// 카운팅 정보
							$('#houseHoldItem3Count').text(totalCount);
							// button show / hide
							$('.code_add_btn:eq(2)').show();
						}
						
					} else {
						alert('목록 호출 실패');
					}
				});	
			},
			
			/**
				목록 click function
			*/
			click : function (thisObj) {
				level1Obj = thisObj;
	
				var thisIdx = thisObj.itemIdx;
	
				// 삭제 클릭 상태인 경우는 무시
				if (!setItem.isDeleteClick) {
					$('.menuUl .holdItemLi').each(function () {
						
						if ($(this).attr('idx') == thisIdx && !$(this).hasClass('active')) {
							$(this).removeClass('hover').addClass('active');
							// 삭제버튼 추가
							$(this).append('<button type="button" class="btn btn-danger btn-xs fr remove_btn">DELETE</button>');
							$(this).attr('')
							level1Idx = thisIdx;
							
						} else {
							$(this).removeClass('active').addClass('hover');
							// 삭제버튼 삭제
							$(this).find('.remove_btn').remove();
							
							if ($(this).attr('idx') == thisIdx) {
								thisIdx = 0;
							}
						}
					});
					
					// 소분류 조회 안되게 중분류의 idx 초기화
					level2Idx = 0;
					
					setItem.list(2);
					setItem.list(3);
					
					$('.holdItemDetailLi.active').removeClass('active');
					$('.holdItemDetailLi .remove_btn, .holdItemDetailLi2 .remove_btn').remove();
				} 
				
				// 삭제 클릭 상태 변경
				setItem.isDeleteClick = false;
				
				// 삭제 button click
				$('.remove_btn').unbind('click').click(function (e) {
					// 이벤트 전파 막기
					e.preventDefault();
					// 삭제 클릭 상태 변경
					setItem.isDeleteClick = true;
					// 삭제 함수 호출
					setItem.del(thisObj);
				});
				
			},
			
			level2Click : function (thisObj) {
				level2Obj = thisObj;
				
				var thisIdx = thisObj.itemIdx;
				
				// 삭제 클릭 상태인 경우는 무시
				if (!setItem.isDeleteDetailClick) {
					$('.menuUl .holdItemDetailLi').each(function () {

						if ($(this).attr('idx') == thisIdx && !$(this).hasClass('active')) {
							$(this).removeClass('hover').addClass('active');
							// 삭제버튼 추가
							$(this).append('<button type="button" class="btn btn-danger btn-xs fr remove_btn">DELETE</button>');
							level2Idx = thisIdx;

						} else {
							$(this).removeClass('active').addClass('hover');
							// 삭제버튼 삭제
							$(this).find('.remove_btn').remove();
							
							if ($(this).attr('idx') == thisIdx) {
								thisIdx = 0;
							}
						}
					});
					
					setItem.list(3);
				} 
				
				
				// 삭제 클릭 상태 변경
				setItem.isDeleteDetailClick = false;
				
				// 삭제 button click
				$('.remove_btn').unbind('click').click(function (e) {
					// 이벤트 전파 막기
					e.preventDefault();
					// 삭제 클릭 상태 변경
					setItem.isDeleteDetailClick = true;
					// 삭제 함수 호출
					setItem.del(thisObj);
				});
				
			},
			
			level3Click : function (thisObj) {
				var thisIdx = thisObj.itemIdx;
				// 삭제 클릭 상태인 경우는 무시
				if (!setItem.isDeleteDetailClick2) {
					$('.menuUl .holdItemDetailLi2').each(function () {

						console.log($(this).attr('idx'));
						if ($(this).attr('idx') == thisIdx && !$(this).hasClass('active')) {
							$(this).removeClass('hover').addClass('active');
							// 삭제버튼 추가
							$(this).append('<button type="button" class="btn btn-danger btn-xs fr remove_btn">DELETE</button>');

						} else {
							$(this).removeClass('active').addClass('hover');
							// 삭제버튼 삭제
							$(this).find('.remove_btn').remove();
							
							if ($(this).attr('idx') == thisIdx) {
								thisIdx = 0;
							}
						}
					});
				} 
				
				
				// 삭제 클릭 상태 변경
				setItem.isDeleteDetailClick2 = false;
				
				// 삭제 button click
				$('.remove_btn').unbind('click').click(function (e) {
					// 이벤트 전파 막기
					e.preventDefault();
					// 삭제 클릭 상태 변경
					setItem.isDeleteDetailClick2 = true;
					// 삭제 함수 호출
					setItem.del(thisObj);
				});
			},
			
			/**
				삭제 function
			*/
			del : function (thisObj) {
				
				param = new URLSearchParams();
				param.append('type'		, 'D');
				param.append('itemIdx'	, thisObj.itemIdx);
				
				// ajax 요청
				if (confirm('삭제하시겠습니까?')) {
					axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
					axios.post('/houseHoldItem/merge', param).then(res => {
						
						if (res.status == 200) {
							
							switch (res.data.resultCnt) {
								case 1 :
									// 알림 호출
									alert('삭제가 완료되었습니다.');
									// 목록 재호출
									setItem.list();
									// 삭제 클릭 상태 변경
									setItem.isDeleteClick = false;
									break;
									
								case 0 || -1 :
									alert('삭제 중 에러가 발생하였습니다.');
									break;
									
								case -2 :
									alert('삭제할 수 없습니다.\n현재 코드를 사용중인 사용자가 있습니다.');
									break;
								
								case -3 :
									alert('삭제할 수 없습니다.\n현재 코드의 하위 코드가 존재합니다.');
									break;
									
								default :
									alert('서버 에러');
									break;
							}
							
						} else {
							alert('서버 에러');
						}
					});
				}
				
			},
			
			
		}
	});

	// 목록 조회
	setItem.list(1);
	
	// 등록 & 수정 & 삭제 Handler
	new Vue({
		el		: '#modalApp',
		methods : {
			save : function (level) {
				var csrfToken 	= '${_csrf.token}';
				var itemName 	= $('#itemName').val();
				var itemCode 	= $('#itemCode').val();

				// validation 체크할 항목 리스트
				var checkArray = [
					{ name : '품목명', 	tag : 'itemName', isEmpty : true },
					{ name : '품목코드', 	tag : 'itemCode', isEmpty : true, isKor : true }
				];
				
				var isValidation = validation.common(checkArray);
				
				if (isValidation) {
					return false;
				}
				
				// 품목명 중복확인
				if (!oldItemName || oldItemName != itemName) {
					var reqParam = {
						name	: '품목명',
						tag		: 'itemName',
						data	: {
							keywordType 				: 'name',
							keyword						: itemName,
							'${_csrf.parameterName}' 	: csrfToken
						}
					};
					isValidation = validation.overlap('/houseHoldItem/nameChk', reqParam);
					if (isValidation) {
						return false;
					}
				}
				
				// 품목코드 중복확인
				if (!oldItemCode || oldItemCode != itemCode) {
					reqParam = {
						name	: '품목코드',
						tag		: 'itemCode',
						data	: {
							keywordType 				: 'code',
							keyword						: itemCode,
							'${_csrf.parameterName}' 	: csrfToken
						}
					};
					isValidation = validation.overlap('/houseHoldItem/nameChk', reqParam);
					if (isValidation) {
						return false;
					}
				}

				var saveType = 'I';
				var saveText = '등록';
				var itemIdx = $('#itemIdx').val();
				if (itemIdx) {
					saveType 	= 'U';
					saveText 	= '수정';
				}
				
				var level = $('#level').val();
				var parentIdx;
				
				if (level == 2) {
					parentIdx = level1Idx;
				} else if (level == 3) {
					parentIdx = level2Idx;			
				}
				
				param = new URLSearchParams();
				param.append('type'			, saveType);
				param.append('itemIdx'		, itemIdx);
				param.append('itemName'		, itemName);
				param.append('itemCode'		, itemCode);
				param.append('level'		, level);
				param.append('itemType'		, $('#itemType').val());
				if (parentIdx) {
					param.append('parentIdx'	, parentIdx);
				}
				
				// ajax 요청
				if (confirm(saveText + ' 하시겠습니까?')) {
					axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken;
					axios.post('/houseHoldItem/merge', param).then(response => {
						if (response.status == 200) {
							// 알림 호출
							alert(saveText + '이 완료되었습니다.');
							// 목록 호출
							setItem.list(level);
							// 팝업 닫기
							$('#codeCloseBtn').click();
							
						} else {
							alert(saveText + ' 실패하였습니다.');
						}
					});
				}
			},
			upd : function () {
				
			},
			del : function () {
				
				param = new URLSearchParams();
				param.append('type'		, 'D');
				param.append('itemIdx'	, $('#itemIdx').val());
				
				// ajax 요청
				if (confirm('삭제하시겠습니까?')) {
					axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
					axios.post('/houseHoldItem/merge', param).then(response => {
						if (response.status == 200) {
							// 알림 호출
							alert('삭제가 완료되었습니다.');
							// 목록 호출
							itemApp.list();
							// 팝업 닫기
							$('#codeCloseBtn').click();
						}
					});
				}
				
			}
		}
	});
	
	eventValidation();
	
	// 코드 추가
	$('.code_add_btn').unbind('click').click(function () {
		
		var thisLevel = $(this).attr('level');
		
		
		switch (thisLevel) {
		
			// 대분류 등록인 경우 상위 품목명 없음
			case '1' :
				$('#parentItemName').val('');
				break;
				
			// 중분류 등록인 경우 대분류의 선택된 항목 표시		
			case '2' :
				$('#parentItemName').val(level1Obj.itemName);
				break;
				
			// 소분류 등록인 경우 중분류의 선택된 항목 표시
			case '3' :
				$('#parentItemName').val(level2Obj.itemName);
				break;
				
			default :
				break;
		}
		
		// 삭제 버튼 hide
		$("#codeDeleteBtn").hide();
		// 팝업 title
		$('#codeAddTitle').text('코드 등록');
		
		// 초기화
		itemIdx = '';
		$('#itemName').val('');
		$('#itemCode').val('');
		$('#itemType option:eq(0)').prop('selected', true);
		
		$('#level').val(thisLevel);
		
		param = new URLSearchParams();
		param.append('level', thisLevel);
		
		if (thisLevel == 2) {
			param.append('parentIdx', level1Obj.itemIdx);
		} else if (thisLevel == 3) {
			param.append('parentIdx', level2Obj.itemIdx);
		}
		
		// ajax 요청
		axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
		axios.post('/houseHoldItem/nextCode', param).then(response => {
			if (response.status == 200) {
				var code = response.data.maxCode;
				var headStr, fixCode;
				
				// 대분류
				if (thisLevel == 1) {
					headStr = code.substring(0, 1);
					fixCode = ( Number(code.substring(1)) + 1 );
					
				// 중분류, 소분류
				} else {
					if (!code) {
						
						if (thisLevel == 2) {
							fixCode = level1Obj.itemCode + '-B001';	
						} else if (thisLevel == 3) {
							fixCode = level2Obj.itemCode + '-C001';
						}	
						 
					} else {
						
						if (thisLevel == 2) {
							headStr = code.substring(0, 6);
							fixCode = ( Number(code.substring(6)) + 1 );
						} else if (thisLevel == 3) {
							headStr = code.substring(0, 11);
							fixCode = ( Number(code.substring(11)) + 1 );
						}
					}
					
				}
				
				if (fixCode < 10) {
					fixCode = headStr + '00' + fixCode;
				} else if (10 <= fixCode && fixCode < 100) {
					fixCode = headStr + '0' + fixCode;
				}

				$('#itemCode').val(fixCode);
			}
		});
	});
	
	// 검색 버튼 click event
	$("#btnSearch").unbind("click").click(function(){
		itemApp.list();
	});
});

function eventValidation () {
	
	var checkArray = [
		{ tag : 'itemName', isLength : true, leng : 10 }
	];
	
	validation.eventCheck(checkArray);
}

</script>


<div id="setItem" class="col-lg-12" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">

	<!-- 대분류 코드 영역 START -->
	<div class="col-lg-35 col-md-4 col-sm-4 col-xs-12 pd0 position_re mgnr50" id="style-3">
		<div class="custom-box tl force-overflow">
			<div class="service-top">
				<h4 class="tc mgnt40">대분류 코드 목록</h4>
				<hr style="width:118px;">
				<div class="tr">전체 : <span id="houseHoldItemCount">0</span></div>
			</div>
			<div class="scrollbar" style="height: 460px; padding: 10px;">
				<ul class="menuUl">
					<!-- 데이터 없을 때 -->
					<li v-if="level1List.length == 0" class="menuLi tc" v-cloak>코드가 없습니다.</li>
					<!-- 데이터 있을 때 -->
					<li v-else class="holdItemLi menuLi hover" v-for="(item, index) in level1List" v-bind:idx="item.itemIdx" v-on:click="click(item);" v-cloak>
						<span>{{index + 1}}. {{ item.itemName }}</span><span class="fr">[{{ item.itemCode }}]</span>
					</li>
				</ul>
			</div>
			<div class="service-bottom tc btn-wrap position_re">
				<button type="button" class="btn btn-outline-primary btn-sm code_add_btn" data-toggle="modal" data-target="#codeAddModal" level="1">등록</button>
			</div>
		</div>
	</div>
	<!-- 대분류 코드 영역 END -->
	
	<!-- 중분류 코드 목록 영역 START -->
	<div class="col-lg-35 col-md-4 col-sm-4 col-xs-12 pd0 position_re mgnr50" id="style-3">
		<div class="custom-box tl force-overflow">
			<div class="service-top">
				<h4 class="tc mgnt40">중분류 코드 목록</h4>
				<hr style="width:152px;">
				<div class="tr">전체 : <span id="houseHoldItem2Count">0</span></div>
			</div>
			<div class="scrollbar" style="height: 460px; padding: 10px;">
				<ul class="menuUl">
					<!-- 데이터 없을 때 -->
					<li v-if="level2List.length == 0" class="menuLi tc">코드가 없습니다.</li>
					<!-- 데이터 있을 때 -->
					<li v-else class="holdItemDetailLi menuLi hover" v-for="(item, index) in level2List" v-bind:idx="item.itemIdx" v-on:click="level2Click(item);" v-cloak>
						<span>{{index + 1}}. {{ item.itemName }}</span><span class="fr">[{{ item.itemCode }}]</span>
					</li> 
				</ul>
			</div>
			<div class="service-bottom tc btn-wrap position_re">
				<button type="button" class="btn btn-outline-primary btn-sm code_add_btn" data-toggle="modal" data-target="#codeAddModal" level="2" style="display:none;">등록</button>
			</div>
		</div>
	</div>
	<!-- 중분류 코드 목록 영역 END -->
	
	
	<!-- 소분류 코드 목록 영역 START -->
	<div class="col-lg-35 col-md-4 col-sm-4 col-xs-12 pd0 position_re" id="style-3">
		<div class="custom-box tl force-overflow">
			<div class="service-top">
				<h4 class="tc mgnt40">소분류 코드 목록</h4>
				<hr style="width:152px;">
				<div class="tr">전체 : <span id="houseHoldItem2Count">0</span></div>
			</div>
			<div class="scrollbar" style="height: 460px; padding: 10px;">
				<ul class="menuUl">
					<!-- 데이터 없을 때 -->
					<li v-if="level3List.length == 0" class="menuLi tc">코드가 없습니다.</li>
					<!-- 데이터 있을 때 -->
					<li v-else class="holdItemDetailLi2 menuLi hover" v-for="(item, index) in level3List" v-bind:idx="item.itemIdx" v-on:click="level3Click(item);" v-cloak>
						<span>{{index + 1}}. {{ item.itemName }}</span><span class="fr">[{{ item.itemCode }}]</span>
					</li> 
				</ul>
			</div>
			<div class="service-bottom tc btn-wrap position_re">
				<button type="button" class="btn btn-outline-primary btn-sm code_add_btn" data-toggle="modal" data-target="#codeAddModal" level="3" style="display:none;">등록</button>
			</div>
		</div>
	</div>
	<!-- 소분류 코드 목록 영역 END -->
</div>


<div id="modalApp">

	<!-- 등록 modal -->
	<div class="modal fade" id="codeAddModal" tabindex="-1" role="dialog" aria-labelledby="codeAddModalLabel" aria-hidden="true">
		<div class="modal-dialog width350">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="codeAddTitle">코드 등록</h4>
				</div>
				<div class="modal-body pdb0">
					<table class="table mgnb0">
						<tbody>
							<tr>
								<th class="tl"> 상위 품목명</th>
								<td>
									<input type="text" class="form-control form-control-inline input-medium" id="parentItemName" readonly/>
									<input type="hidden" id="parentIdx"/>
								</td>
							</tr>
							<tr>
								<th class="tl"><span class="font-red">*</span> 품목 코드</th>
								<td><input type="text" class="form-control form-control-inline input-medium" id="itemCode" readonly/></td>
							</tr>
							<tr>
								<th class="tl"><span class="font-red">*</span> 품목명</th>
								<td>
									<input type="text" class="form-control form-control-inline input-medium" id="itemName"/>
									<input type="hidden" id="itemIdx"/>
									
									<input type="hidden" id="level"/>
								</td>
							</tr>
							<tr>
								<th class="tl"><span class="font-red">*</span> 품목 유형</th>
								<td>
									<select class="form-control" id="itemType">
										<option value="R">수익</option>
										<option value="E">지출</option>
										<option value="S">저축</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="codeCloseBtn" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="codeDeleteBtn"  v-on:click="del()">삭제</button>
					<button type="button" class="btn btn-primary" id="codeInsertBtn"  v-on:click="save()">저장</button>
				</div>
			</div>
		</div>
	</div>
	
</div>

<script>
</script>