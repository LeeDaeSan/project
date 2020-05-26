<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
[v-cloak] {display: none}
</style>
<script>
var oldItemCode;
var oldItemName;

var itemApp;

$(function () {

	Vue.component('page-component', {
		template	: '<ul>{{pagetag}}</ul>',
		props		: ['pagetag']
			
	});
	
	// 목록 Handler
	itemApp = new Vue({
		el		: '#itemApp',
		data 	: {
			itemList 	: [],
			
			limit		: 10,		// 목록의 limit
			page		: 1,		// 현재 페이지
			totalCount 	: 0,		// 목록 총 갯수
			pageLimit	: 10,		// 페이지의 limit
			pageTag		: '',		// 바인딩되는 페이징 html
			firstPage	: 1,		// 전체 페이지의 시작 번호
			lastPage	: 1,		// 전체 페이지의 마지막 번호
			startPage	: 1,		// 현재 페이징의 시작 번호
			endPage		: 1,		// 현재 페이징의 마지막 번호
		},
		methods : {
			
			// 목록 호출
			list	: function () {
				
				var param = new URLSearchParams();
				startPage = (this.page * this.limit - this.limit);
				param.append('page', 	startPage);
				param.append('limit', 	this.limit);
				
				// [필수설정]
				axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
				// Promise
				axios.post('/houseHoldItem/list', param).then(response => {
					if (response.status == 200) {
						$.each(response.data.list, function () {
							// 생성일
							this.createDate = converter.date.dateTime.toString(new Date(this.createDate), '-');
							
							// 품목유형
							var itemType = '';
							if (this.itemType == 'E') 
								itemType = '지출';
							else if (this.itemType == 'R') 
								itemType = '수익';
							
							this.itemType = itemType; 
							
							this['rowNo'] = ++startPage;
						});
						
						// list
						itemApp.itemList = response.data.list;
						// paging
						this.paging(response.data.totalcount);
						paging.getEvent(response.data.totalcount, this);
					} else {
						alert('목록 호출 실패');
					}
				});
			},
			
			// 페이지 이동
			selectPage : function (page) {
				this.page = page;
				this.list();
			},
			// 페이징 생성
			paging	: function (totalcount) {
				this.totalCount = totalcount;
				
				var isNext = true;
				
				var totalPage = Math.ceil(totalcount / this.limit);
				
				var pageHtml = '';
				
				// 페이징의 시작 페이지번호
				var sPage = parseInt(this.page / this.pageLimit);
				
				if (this.page % this.pageLimit == 0) {
					sPage--;
				}
				
				// 페이징의 마지막 페이지번호
				var ePage = (sPage + 1) * this.pageLimit;
				if (ePage > totalPage) {
					ePage = totalPage;
					isNext = false;
				}
				
				sPage = sPage * this.pageLimit + 1;
				
				if (this.firstPage < sPage) {
					pageHtml += '<li class="prev disabled"><a href="javascript:selectPage(' + (sPage - this.pageLimit) + ')">PREV</a></li>';
				}
				
				for (var i = sPage; i <= ePage; i++) {
					pageHtml += '<li class="' + (this.page == i ? 'active' : '') + '">';
					pageHtml += '	<a href=\"javascript:selectPage(' + i + ')\">' + i + '</a>';
					pageHtml += '</li>';
				}
				
				if (isNext) {
					pageHtml += '<li class="next disabled"><a href="javascript:selectPage(' + (ePage + 1) + ')" id="nextBtn">NEXT</a></li>';
				}
				
				this.pageTag = pageHtml;

			},
			
			// 상세정보 호출
			detail 	: function (itemIdx) {
				$('#codeAddTitle').text('코드 상세');
				
				param = new URLSearchParams();
				param.append('itemIdx', itemIdx);
				
				axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
				axios.post('/houseHoldItem/detail', param).then(response => {
					if (response.status == 200) {
						
						var data = response.data.detail;
						oldItemName = data.itemName;
						oldItemCode = data.itemCode;

						$('#itemIdx').val(data.itemIdx);
						$('#itemName').val(oldItemName);
						$('#itemCode').val(oldItemCode);
						$('#itemType').val(data.itemType);
						
					} else {
						alert('상세 호출 실패');
					}
				});
			}
		
		}
	});

	// 목록 호출
	itemApp.list();
	
	// 등록 & 수정 & 삭제 Handler
	new Vue({
		el		: '#modalApp',
		methods : {
			save : function () {
				
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
				
				param = new URLSearchParams();
				param.append('type'		, saveType);
				param.append('itemIdx'	, itemIdx);
				param.append('itemName'	, itemName);
				param.append('itemCode'	, itemCode);
				param.append('itemType'	, $('#itemType').val());
				
				// ajax 요청
				if (confirm(saveText + ' 하시겠습니까?')) {
					axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken;
					axios.post('/houseHoldItem/merge', param).then(response => {
						if (response.status == 200) {
							if (response.data.resultCnt == 1) {
								// 알림 호출
								alert(saveText + '이 완료되었습니다.');
								// 목록 호출
								itemApp.list();	
							} else {
								alert(saveText + ' 작업이 실패하였습니다.');
							}
							
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
	$('#codeAddBtn').unbind('click').click(function () {
		$('#codeAddTitle').text('코드 등록');
		
		itemIdx = '';
		$('#itemName').val('');
		$('#itemCode').val('');
		$('#itemType option:eq(0)').prop('selected', true);
	});
});

function selectPage (page) {
	itemApp.selectPage(page);
}

function eventValidation () {
	
	var checkArray = [
		{ tag : 'itemName', isLength : true, leng : 10 }
	];
	
	validation.eventCheck(checkArray);
}

</script>

<div>
	<h3 class="fl"><i class="fl fa fa-angle-right"></i>&nbsp;가계부 품목 관리</h3>
</div>

<!-- 대분류 항목 목록 START -->
<div class="row" id="itemApp">
	<div class="col-md-12">
		<h4 class="fl"><i class="fa fa-bar-chart-o"></i>&nbsp;대분류 항목 목록</h4>
		<div class="fr">
			<button type="button" class="btn btn-sm btn-primary" id="codeAddBtn" data-toggle="modal" data-target="#codeAddModal">대분류 항목 등록</button>
		</div>
	</div>
	<div class="col-md-12">
		<div class="content-panel" style="height:400px;">
			<table class="table table-striped table-advance table-hover">
				<thead>
					<tr>
						<th class="tc">번호</th>
						<th class="tc">품목명</th>
						<th class="tc">품목코드</th>
						<th class="tc">품목유형</th>
						<th class="tc">생성자</th>
						<th class="tc">생성일</th>
					</tr>
				</thead>	
				<tbody>
					<tr v-for="(item, index) in itemList" v-on:click="detail(item.itemIdx)" data-toggle="modal" data-target="#codeAddModal" v-cloak>
						<td class="tc">{{ item.rowNo 			}}</td>
						<td class="tl">{{ item.itemName			}}</td>
						<td class="tl">{{ item.itemCode			}}</td>
						<td class="tc">{{ item.itemType			}}</td>
						<td class="tc">{{ item.createMemberName	}}</td>
						<td class="tc">{{ item.createDate		}}</td>
					</tr>
				</tbody>		
			</table>
		</div>
		
		<!-- Pagination START -->
		<div id="pagination" class="dataTables_paginate paging_bootstrap pagination">
			<page-component v-html:pagetag="pageTag"></page-component>
		</div>
		<!-- Pagination END -->
	</div>
</div>
<!-- 대분류 항목 목록 END -->


<!-- 중분류 항목 목록 START -->
<div class="row" id="itemDetailApp">
	<div class="col-md-12">
		<h4 class="fl"><i class="fa fa-bar-chart-o"></i>&nbsp;중분류 항목 목록</h4>
		<div class="fr">
			<button type="button" class="btn btn-sm btn-primary" id="codeAddBtn" data-toggle="modal" data-target="#codeAddModal">대분류 항목 등록</button>
		</div>
	</div>
	<div class="col-md-12">
		<div class="content-panel" style="height:400px;">
			<table class="table table-striped table-advance table-hover">
				<thead>
					<tr>
						<th class="tc">번호</th>
						<th class="tc">품목명</th>
						<th class="tc">품목코드</th>
						<th class="tc">품목유형</th>
						<th class="tc">생성자</th>
						<th class="tc">생성일</th>
					</tr>
				</thead>	
				<tbody>
					<tr v-for="(item, index) in itemList" v-on:click="detail(item.itemIdx)" data-toggle="modal" data-target="#codeAddModal" v-cloak>
						<td class="tc">{{ item.rowNo 			}}</td>
						<td class="tl">{{ item.itemName			}}</td>
						<td class="tl">{{ item.itemCode			}}</td>
						<td class="tc">{{ item.itemType			}}</td>
						<td class="tc">{{ item.createMemberName	}}</td>
						<td class="tc">{{ item.createDate		}}</td>
					</tr>
				</tbody>		
			</table>
		</div>
		
		<!-- Pagination START -->
		<div id="pagination" class="dataTables_paginate paging_bootstrap pagination">
			<page-component v-html:pagetag="pageTag"></page-component>
		</div>
		<!-- Pagination END -->
	</div>
</div>
<!-- 중분류 항목 목록 END -->


<div id="modalApp">

	<!-- 등록 modal -->
	<div class="modal fade" id="codeAddModal" tabindex="-1" role="dialog" aria-labelledby="codeAddModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:350px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="codeAddTitle">코드 등록</h4>
				</div>
				<div class="modal-body">
					<table class="table">
						<tbody>
							<tr>
								<th>품목명</th>
								<td>
									<input type="text" id="itemName"/>
									<input type="hidden" id="itemIdx"/>
								</td>
							</tr>
							<tr>
								<th>품목 코드</th>
								<td><input type="text" id="itemCode"/></td>
							</tr>
							<tr>
								<th>품목 유형</th>
								<td>
									<select id="itemType">
										<option value="R">수익</option>
										<option value="E">지출</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sm btn-default" id="codeCloseBtn" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-sm btn-primary" id="codeDeleteBtn"  v-on:click="del()">삭제</button>
					<button type="button" class="btn btn-sm btn-primary" id="codeInsertBtn"  v-on:click="save()">저장</button>
				</div>
			</div>
		</div>
	</div>
	
</div>

<script>
</script>