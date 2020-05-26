<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- fullcalendar -->
<script type="text/javascript" src="/js/calendar.js"></script>
<link href="/css/common/calendar.css" rel="stylesheet" type="text/css"/>


<script>

$(function () {
	
	var calendarApp = new Vue({
		el		: '#calendar',
		data 	: {
			toDay		: new Date(),
			calendar 	: null,
			dataList	: null,
		},
		mounted () {
			var thisApp = this;
			
			// calendar 생성
			thisApp.calendar = new Calendar.init(
				$('#calendar'),
				{
					type 		: 'month',
					toDay 		: thisApp.toDay,
					week		: ['일', '월', '화', '수', '목', '금', '토'],
					buttonAttr 	: 'data-toggle="modal" data-target="#detailModal"'
				}
			);

			// 날짜 변경
			thisApp.setDay(thisApp.toDay);
			
			// 목록 조회
			thisApp.list(thisApp.toDay);
			
			// prev / next click event
			$('.calendar-shift-btn').unbind('click').click(function (e) {
				e.preventDefault();
				
				var options = thisApp.calendar.options;
				
				options.toDay = Calendar.monthCalcuration(
					$(this).attr('year'), $(this).attr('month'), $(this).attr('type')
				);

				// calendar 초기화
				thisApp.calendar.init($('#calendar'), options);
				// 날짜 text 변경
				thisApp.setDay(options.toDay);
				// 목록 조회
				thisApp.list(options.toDay);
			});
			
		},
		methods : {
			
			// 날짜 변경에 따른 year, month 변경
			setDay : function (date) {
				var year = date.getFullYear();
				var month = date.getMonth();
				
				$('.calendar-shift-btn').attr('year', year);
				$('.calendar-shift-btn').attr('month', month);
				
				$('.header-year').empty().append(date.getFullYear() + '년');
				$('.header-month').empty().append((date.getMonth() + 1) + '월');
			},
			
			// 목록 조회
			list : function (toDay) {
				var thisApp = this;
				
				var param = new URLSearchParams();
				param.append('holdDateStr'	, dateToString(toDay, '-'));
				param.append('periodType'	, 'M');
				
				axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
				axios.post('/memberHoldItem/list', param).then(response => {
					
					if (response.status == 200) {
						
						// 입금 금액
						$('#inAmount').empty().append(
							converter.number.addComma(response.data.inAmount)		
						);
						// 출금 금액
						$('#outAmount').empty().append(
							converter.number.addComma(response.data.outAmount)		
						);
						
						// 초기화
						$('#calendar .calendar-table-layout tbody tr td div.day_text').each(function () {
							$(this).empty();
						});
						
						// 목록
						thisApp.dataList = response.data.list;
						$.each(thisApp.dataList, function (i, item) {
							
							var holdDate = this.holdDate.split('T')[0];
								holdDate = holdDate.replace(/-/g, '');
								
							var thisTag = $('#calendar .calendar-table-layout tbody tr td div.day_' + Number(holdDate.substring(6, 8)));

							// 한 날의 데이터가 5개 이상인 경우 생략
							if (thisTag.find('div').length > 4) {
								return true;
								
							// 한 날의 데이터가 4개인 경우 ... 처리
							} else if (thisTag.find('div').length == 4) {
								
								var thisText = '<div class="text-rest"><span class="fr">...</span></div>';
								thisTag.append(thisText);
								
							} else {
								
								var thisText  = '<div class="' + (this.type == 'I' ? 'text-in-blue' : 'text-out-red') + '">';
									thisText += '	<span class="fl">' + this.houseHoldItem.itemName + '</span>';
									thisText += ' 	: ';
									thisText += '	<span class="fr">' + (this.type == 'I' ? '+' : '-') + converter.number.addComma(this.amount) + '</span>';
									thisText += '</div>';
									
								thisTag.append(thisText);
							}
						});
						
						// 일별 click event
						$('.day_click').unbind('click').click(function (e) {
							// 이벤트 전파 막기
							e.preventDefault();
						
							$('.day_click').removeClass('selected').addClass('day_hover');
							
							if ($(this).hasClass('selected')) {
								$(this).removeClass('selected').addClass('day_hover');
								
							} else {
								$(this).addClass('selected').removeClass('day_hover');
							}
							
							// 상세 목록 조회
							detailApp.list($(this).attr('thisDate'));
						});
					}
					
				});
			}
		},
	});

	// 등록 팝업
	var holdApp = new Vue({
		el 		: '#modalApp',
		data 	: {
			houseHold1List 	: [],	// 대분류 품목 목록
			houseHold2List 	: [], 	// 중분류 품목 목록
			houseHold3List 	: [],	// 소분류 품목 목록
			level			: 1,
			parentIdx		: 0,
		},
		methods : {
			
			/**
				목록 초기화
			*/
			init : function () {
				var thisApp = this;
				var level 	= thisApp.level;
				
				$('#holdDate').datepicker({
					format		: 'yyyy-mm-dd',
					autoClose 	: true,
				});
				
				var params = new URLSearchParams();
				params.append('level'		, level);
				params.append('parentIdx'	, thisApp.parentIdx);
				
				axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
				axios.post('/houseHoldItem/selectOfPopup', params).then(response => {
					if (response.status == 200) {
	
						// 대분류
						if (level == 1) {
							thisApp.houseHold1List = response.data.list;
							
						// 중분류
						} else if (level == 2) {
							thisApp.houseHold2List = response.data.list;
							
						// 소분류
						} else if (level == 3) {
							thisApp.houseHold3List = response.data.list;
						}
						
					} else {
						alert('대분류 품목 조회 에러');
					}
				});
			},
			
			/**
				대분류 change event
			*/
			selectOfChange : function (level, event) {
				
				// 중분류 조회 데이터 변경
				holdApp.level = level;
				holdApp.parentIdx = event.target.value;
				
				// 목록 조회
				holdApp.init();
			},
			
			/**
				저장
			*/
			save : function () {
				
				var holdDate 	= $('#holdDate').val();
				var amount 		= converter.number.removeComma($('#amount').val());
				var type		= $('#type').val();
				var fontColor	= $('#fontcolor').val();
				var remark 		= $('#remark').val();
				
				var checkArray = [
					{name : '등록일', 	tag : 'holdDate', 	isEmpty : true},
					{name : '금액', 		tag : 'amount', 	isEmpty : true}
				];
				
				var isValidation = validation.common(checkArray);
				
				if (isValidation) {
					return false;
				}
				
				var param = new URLSearchParams();
				param.append('holdDateStr'				, holdDate);
				param.append('item1Idx'					, $('#houseHoldItem1').val());
				param.append('item2Idx'					, $('#houseHoldItem2').val());
				param.append('item13Idx'				, $('#houseHoldItem3').val());
				param.append('fontColorIdx'				, 1);
				param.append('amount'					, amount);
				param.append('type'						, type);
				param.append('remark'					, remark);
				param.append('mergeType'				, 'I');
				
				// ajax 요청
				if (confirm('등록하시겠습니까?')) {
					axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
					axios.post('/memberHoldItem/merge', param).then(response => {
						if (response.status == 200) {
							
							// 목록 재조회
							calendarApp.list(converter.date.basic.toDate(holdDate, '-'));
							// 닫기
							$('#codeCloseBtn').click();
							
						} else {
							alert('등록 실패하였습니다.');
						}
					})
				}
			}
		}
	});
	
	// 일별 상세 팝업
	var detailApp = new Vue({
		el		: '#modalDetailApp',
		data 	: {
			dailyDetailList : [],	// 일별 상세 목록
			thisDay : '',
		},
		methods : {
			list : function (thisDay) {
				var thisApp = this;
				thisApp.thisDay = thisDay;
				
				var param = new URLSearchParams();
				param.append('holdDateStr'	, thisApp.thisDay);
				param.append('periodType'	, 'D');
				
				axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
				axios.post('/memberHoldItem/list', param).then(response => {
					
					if (response.status == 200) {
						
						// 목록 binding
						thisApp.dailyDetailList = response.data.list.filter(function (item) {
							
							// 금액 comma 처리
							item.amount = converter.number.addComma(item.amount);
							// 클래스
							item['classType'] = (item.type == 'I' ? 'text-in-blue' : 'text-out-red');
							// 유형							
							item.type = (item.type == 'I' ? '입금' : '출금');
							
							return item;
						});
						
					} else {
						
					}
					
				});
			},
			
			/**
				삭제
			*/
			del : function (idx) {
				var thisApp = this;
				
				if (confirm('삭제하시겠습니까?')) {
					
					var param = new URLSearchParams();
					param.append('memberHoldItemIdx', idx);
					param.append('mergeType'		, 'D');
					
					// ajax 요청
					axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
					axios.post('/memberHoldItem/merge', param).then(response => {
						if (response.status == 200) {
							
							// success
							if (response.data.resultCnt == 1) {

								// 목록 재조회
								thisApp.list(thisApp.thisDay);
								alert('삭제를 완료했습니다.');
								
							// error
							} else {
								alert('서버 에러');
							}
							
						} else {
							alert('삭제 실패하였습니다.');
						}
					})
				}
				
			}
		}
	});
	
	// 가계 등록 button event
	$('#addBtn').unbind('click').click(function (e) {
		e.preventDefault();
		holdApp.init(1);
	});

	// 금액
	$('#amount').keyup(function (e) {
		e.preventDefault();

		// 숫자 외의 문자는 공백 치환
		$(this).val($(this).val().replace(/[^0-9]/g, ''));
		// 천단위 콤마 찍기
		$(this).val(converter.number.addComma($(this).val().replace(/\,/gi, '')));
	});
});


</script>

<style>
#calendar{height:720px;}
.button-area{position:absolute;right:15px;}
.amount-area{position:absolute;left:15px;top:32px;font-weight:bold;}
.amount-text{color:#000000;}
</style>
	
<!-- Calendar 영역 START -->
<div class="row pdt20">
	<div class="col-md-12">
	
		<!-- 상단 좌측 금액 영역 START -->
		<div class="tl amount-area">
			<span class="amount-text">입금 : </span><span class="text-in-blue" id="inAmount">0</span>
			<span>&nbsp;/&nbsp;</span>
			<span class="amount-text">출금 : </span><span class="text-out-red" id="outAmount">0</span>
		</div>
		<!-- 상단 좌측 금액 영역 END -->
		
		<!-- 상단 우측 버튼 영역 START -->
		<div class="tr button-area">
			<button type="button" id="addBtn" class="btn btn-outline-primary" data-toggle="modal" data-target="#addModal">가계 등록</button>
		</div>
		<!-- 상단 우측 버튼 영역 END -->
		
		<!-- 상단 중앙 버튼 영역 START -->
		<div class="calendar-header-wrap">
			<div class="header-full-wrap">
				<span>
					<span class="calendar-shift-btn-left calendar-shift-btn" type="M"><</span>
				</span>
				<span class="header-year">2019년</span>
				<span class="header-month">12월</span>
				<span>
					<span class="calendar-shift-btn-right calendar-shift-btn" type="P">></span>
				</span>
			</div>
		</div>
		<!-- 상단 중앙 버튼 영역 END -->
		
		<!-- calendar 영역 START -->
		<div id="calendar"></div>
		<!-- calendar 영역 END -->	
		
	</div>
</div>
<!-- Calendar 영역 END -->


<!-- 가계 등록 modal START -->
<div id="modalApp">
	<div class="modal fade" id="addModal"  tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
		<div class="modal-dialog width500">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="codeAddTitle">가계 등록</h4>
				</div>
				<div class="modal-body pdb0">
					<table class="table mgnb0">
						<tbody>
							<tr>
								<th class="tl"><span class="font-red">*</span> 등록일</th>
								<td>
									<input type="text" id="holdDate" class="form-control dpd1" name="daterangepicker_start">
								</td>
							</tr>
							<tr>
								<th class="tl"><span class="font-red">*</span> 품목</th>
								<td>
									<div class="pdr15-imp col-lg-4">
										<select class="form-control" id="houseHoldItem1" v-on:change="selectOfChange(2, $event)">
											<!-- 데이터가 없거나 상위 선택자가 없는 경우 -->
											<option v-if="houseHold1List.length == 0">선택 없음</option>
											<!-- 목록 조회 -->
											<option v-for="(item, index) in houseHold1List" :value="item.itemIdx" v-cloak>{{item.itemName}}</option>
										</select>
									</div>
									<div class="pd-none col-lg-4">
										<select class="form-control" id="houseHoldItem2" v-on:change="selectOfChange(3, $event)">
											<!-- 데이터가 없거나 상위 선택자가 없는 경우 -->
											<option v-if="houseHold2List.length == 0">선택 없음</option>
											<!-- 목록 조회 -->
											<option v-for="(item, index) in houseHold2List" :value="item.itemIdx" v-cloak>{{item.itemName}}</option>
										</select>
									</div>
									<div class="pdl15-imp col-lg-4">
										<select class="form-control" id="houseHoldItem3">
											<!-- 데이터가 없거나 상위 선택자가 없는 경우 -->
											<option v-if="houseHold3List.length == 0">선택 없음</option>
											<!-- 목록 조회 -->
											<option v-for="(item, index) in houseHold3List" :value="item.itemIdx" v-cloak>{{item.itemName}}</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th class="tl"><span class="font-red">*</span> 품목 상세</th>
								<td>
									<select class="form-control" id="itemType">
										<option value="R">수익</option>
										<option value="E">지출</option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="tl"><span class="font-red">*</span> 금액</th>
								<td>
									<input type="text" class="form-control tr" id="amount"/>
								</td>
							</tr>
							<tr>
								<th class="tl"><span class="font-red">*</span> 유형</th>
								<td>
									<select class="form-control" id="type">
										<option value="I">입금</option>
										<option value="O">출금</option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="tl">비고</th>
								<td>
									<input type="text" class="form-control" id="remark"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="codeCloseBtn" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="codeDeleteBtn" style="display:none;">삭제</button>
					<button type="button" class="btn btn-primary" id="codeInsertBtn"  v-on:click="save()">저장</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 가계 등록 modal END -->


<!-- 가계 일별 상세 목록 modal START -->
<div id="modalDetailApp">
	<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="detailModalLabel" aria-hidden="true">
		<div class="modal-dialog width1000">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="codeAddTitle">일별 가계 목록</h4>
				</div>
				<div class="modal-body pdb0 height350" style="overflow:auto;">
					목록
					<table class="table table-bordered table-striped table-condensed mgnb0">
						<colgroup>
							<col width="5%"/>
							<col width="13%"/>
							<col width="13%"/>
							<col width="13%"/>
							<col width="15%"/>
							<col width="10%"/>
							<col width="25%"/>
							<col width="5%"/>
						</colgroup>
						<thead>
							<tr>
								<th>NO</th>
								<th>품목1</th>
								<th>품목2</th>
								<th>품목3</th>
								<th>금액</th>
								<th>유형</th>
								<th>비고</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody class="border-bottom1">
							<tr v-for="(item, index) in dailyDetailList" v-cloak>
								<td class="tc">{{ index + 1 }}</td>
								<td class="tl">{{ item.houseHoldItem.itemName}}</td>
								<td class="tl">{{ item.houseHoldItem2 ? item.houseHoldItem2.itemName : '' }}</td>
								<td class="tl">{{ item.houseHoldItem3 ? item.houseHoldItem3.itemName : '' }}</td>
								<td class="tr" :class="item.classType">{{ item.amount }}</td>
								<td class="tc">{{ item.type }}</td>
								<td class="tl">{{ item.remark }}</td>
								<td class="tc"><button class="btn btn-xs btn-outline-danger" type="button" v-on:click="del(item.memberHoldItemIdx)">삭제</button></td>
							</tr>
							
							<tr v-if="dailyDetailList.length == 0">
								<td colspan="7" class="tc">데이터가 없습니다.</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="codeCloseBtn" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 가계 일별 상세 목록 modal END -->


