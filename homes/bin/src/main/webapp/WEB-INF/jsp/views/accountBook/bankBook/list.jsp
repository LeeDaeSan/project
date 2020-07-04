<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
table{border-top:1px solid #dddddd;border-bottom:1px solid #dddddd;}
table#bankBookTable{table-layout:fixed;width:100%;}
.top-button-area{height:35px;margin-bottom:5px;}
.search-title{padding-left:10px;}
.total-amount-span{padding-top:15px;}
#searchBtn{margin-right:5px;}
.custom-checkbox{margin-right:15px;}
#myInsertModalLabel, #myUpdateModalLabel{font-weight:bold;}
</style>

<script type="text/javascript">
$(function () {
	
	// 검색조건 은행목록 조회
	bankList('S');
	
	// 가계부 검색
	$('#searchBtn').unbind('click').click(function (e) {
		e.preventDefault();
		// 가계부 목록 조회
		bankBookList();
	});
	
	// 가계부 목록 조회
	$('#searchBtn').click();
	
	$('.datepicker').datepicker({
		format 		: 'yyyy-mm-dd',		// 포맷 형식
		autoclose 	: true,				// 날짜 선택시 자동 close
	});
	
	// 등록 팝업 open button
	document.getElementById('insertModalOpenBtn').onclick = function (e) {
		// 이벤트 전파 방지
		e.preventDefault();
		
		// 은행 목록 조회
		bankList('I');
		// 통장 유형 목록 조회
		bankBookTypeList('I');
		
		return false;
	};
	
	// 등록 button
	document.getElementById('insertBtn').onclick = function (e) {
		// 이벤트 전파 방지
		e.preventDefault();

		if (confirm('등록하시겠습니까?')) {
			$.ajax({
				url 		: '/rest/bankBook/merge',
				method 		: 'POST',
				dataType 	: 'JSON',
				data		: {
					type			: 'I',									// 저장 유형
					bankIdx 		: $('#bankSelect').val(),				// 은행 PK
					bankBookTypeIdx : $('#bankBookTypeSelect').val(),		// 통장 유형 PK
					bankBookName 	: $('#bankBookName').val(),				// 은행명
					openDateStr		: $('#openDate').val(),					// 개설일
					closeDateStr	: $('#closeDate').val(),				// 만기일
					acountNumber	: $('#acountNumber').val(),				// 계좌번호 
				},
				success		: function (result) {
					if (result.status) {
						alert('등록이 완료되었습니다.');
						// 팝업 닫기
						$('#insertCloseBtn').click();
						// 가계부 목록 조회
						bankBookList();
					}
				}
			});
			
		} else {
			alert('등록을 취소하였습니다.');
		}
		
		return false;
	}
	
	// 수정하기
	document.getElementById('updateBtn').onclick = function (e) {
		e.preventDefault();
		
		if (confirm('수정하시겠습니까?')) {
			$.ajax({
				url 		: '/rest/bankBook/merge',
				method 		: 'POST',
				dataType 	: 'JSON',
				data 		: {
					type 			: 'U',
					bankBookIdx 	: $('#updateBankBookIdx').val(),
					bankIdx 		: $('#updateBankSelect').val(),
					bankBookName 	: $('#updateBankBookName').val(),
					acountNumber 	: $('#updateAcountNumber').val(),
					bankBookTypeIdx : $('#updateBankBookTypeSelect').val(),
					totalAmount 	: common.number.onlyNumber($('#updateTotalAmount').val()),
					openDateStr 	: $('#updateOpenDate').val(),
					closeDateStr 	: $('#updateCloseDate').val()
				},
				success 	: function (result) {
					if (result.status) {
						alert('수정을 완료하였습니다.');
						$('#updateCloseBtn').click();
						$('#searchBtn').click();
					} else {
						alert('서버 에러');
					}
				}
			});
		}
	}
	
	// 삭제하기
	document.getElementById('deleteBtn').onclick = function (e) {
		e.preventDefault();	
		
		if (confirm('통장을 삭제하시겠습니까?\n삭제할 경우 상세 정보도 모두 삭제됩니다.')) {
			
			$.ajax({
				url 		: '/rest/bankBook/merge',
				method 		: 'POST',
				dataType 	: 'JSON',
				data 		: {
					type 			: 'D',
					bankBookIdx 	: $('#updateBankBookIdx').val(),
				},
				success 	: function (result) {
					if (result.status) {
						alert('통장 삭제를 완료하였습니다.');
						$('#updateCloseBtn').click();
						$('#searchBtn').click();
					} else {
						alert('서버 에러');
					}
				}
			});
		}
	}
	
	// 총 금액 keyup event
	$('#updateTotalAmount').off('keyup').keyup(function (e) {
		e.preventDefault();
		
		var thisData = common.number.onlyNumber($(this).val());
			thisData = common.number.addComma(thisData);
			
		$(this).val(thisData);
	});
});

/**
 * 가계부 목록 조회
 */
function bankBookList () {
	
	var bankCheckeds = '';
	$('.bank_data_check').each(function () {
		if ($(this).prop('checked')) {
			if (!bankCheckeds) {
				bankCheckeds += $(this).val();
			} else {
				bankCheckeds += ',' + $(this).val();
			}
		}
	});
	
	$.ajax({
		url 		: '/rest/bankBook/list',
		data 		: {
			bankIdx 		: $('#searchBankSelect').val(),			// 은행
			allChecked		: $('.bank_all_check').prop('checked'),
			checkedList 	: bankCheckeds,
			startDateStr1 	: $('#startDateOpen').val(),
			endDateStr1		: $('#endDateOpen').val(),
			startDateStr2	: $('#startDateClose').val(),
			endDateStr2		: $('#endDateClose').val(),
			
		},
		type 		: 'POST',
		dataType 	: 'JSON'
		
	// 결과
	}).done(function (result) {
		
		if (result.status) {
			// 초기화
			$('#bankBookTable tbody').empty();
			
			var totalAmount = 0;
			
			var list = result.list;
			var listLength = list.length;
			for (var i = 0; i < listLength; i++) {
				var thisData = list[i];
				
				totalAmount += thisData.totalAmount;
				
				var html  = '<tr class="bankBook_detail" idx="' + thisData.bankBookIdx + '">';
				
				if (thisData.bankBookType) {
					// 가계통장인 경우
					var mainType = false;
					if (thisData.bankBookType.bankBookTypeIdx == 1) {
						mainType = true;
						thisData.bankBookType.typeName = '*' + thisData.bankBookType.typeName;
					}
					html += '	<td class="text-tooltip text-center' + (mainType ? ' color-orange font-bold' : '') + '">' + (thisData.bankBookType.typeName ? thisData.bankBookType.typeName : '') + '</td>';
				} else {
					html += '	<td class="text-tooltip text-center"></td>';
				}
					html += '	<td class="text-tooltip text-center">' + thisData.member.memberName + '</td>';
					html += '	<td class="text-tooltip">' + common.string.toEmpty(thisData.bankBookName) + '</td>';
					html += '	<td class="text-tooltip text-center">' + common.string.toEmpty(thisData.bank.bankName) + '</td>';
					html += '	<td class="text-tooltip">' + common.string.toEmpty(thisData.acountNumber) + '</td>';
					html += '	<td class="text-tooltip text-right color-green">' + (thisData.totalAmount ? common.number.addComma(thisData.totalAmount) : 0) + '</td>';
					html += '	<td class="text-tooltip text-center">' + common.date.toString(new Date(list[i].openDate), '-') + '</td>';
					html += '	<td class="text-tooltip text-center">' + (list[i].closeDate ? common.date.toString(new Date(list[i].closeDate), '-') : '') + '</td>';
					html += '	<td class="text-tooltip text-center"><button type="button" class="btn btn-secondary btn-sm btn_bankBook_detail" idx="' + thisData.bankBookIdx + '">상세보기</button></td>';
					html += '</tr>';
					
				$('#bankBookTable tbody').append(html);
			}
			
			// 총 잔액
			$('#totalAmount').text(common.number.addComma(totalAmount));
			
			// 가계부 상세 팝업 열기 (수정, 삭제)
			$('.bankBook_detail').unbind('click').click(function (e) {
				// 이벤트 전파 방지
				e.preventDefault();
				// 팝업 modal open
				$('#updateModal').modal();
				// 은행 목록 조회
				bankList('U');
				// 통장 유형 목록 조회
				bankBookTypeList('U');
				
				$.ajax({
					url 		: '/rest/bankBook/detail',
					method 		: 'POST',
					dataType 	: 'JSON',
					data 		: {
						bankBookIdx : $(this).attr('idx')
					},
					success 	: function (result) {
						if (result.status) {
							var detail = result.detail;

							// 팝업 제목
							$('#myUpdateModalLabel').text(detail.bankBookName);
							
							$('#updateBankBookIdx').val(detail.bankBookIdx);											// 은행
							$('#updateBankBookTypeIdx').val(detail.bankBookTypeIdx);
							$('#updateBankBookTypeSelect').val(detail.bankBookTypeIdx);									// 통장 유형
							$('#updateBankBookName').val(detail.bankBookName);											// 통장 명
							$('#updateAcountNumber').val(detail.acountNumber);											// 계좌번호
							$('#updateTotalAmount').val(common.number.addComma(detail.totalAmount));					// 잔액
							$('#updateOpenDate').val(
									detail.openDate ? common.date.toString(new Date(detail.openDate), '-') : '');		// 개설일
							$('#updateCloseDate').val(
									detail.closeDate ? common.date.toString(new Date(detail.closeDate), '-') : '');		// 만기일
							
						} else {
							alert('서버 에러');
						}
					}
				});
			});
			
			// 가계부 상세 화면 이동
			$('.btn_bankBook_detail').unbind('click').click(function (e) {
				// 이벤트 전파 방지
				e.preventDefault();
				// 상세 페이지 이동				
				location.href = 'detail?idx=' + $(this).attr('idx');
			});
			
			// 데이터 없을 때
			if (result.list.length == 0) {
				$('#bankBookTable tbody').append('<tr><td colspan="9" class="text-center">데이터가 없습니다.</td></tr>');
			}
		}
	});
}

/**
 * 은행 목록 조회
 */
function bankList (type) {
	
	$.ajax({
		url 		: '/bank/list',
		data 		: {},
		type 		: 'POST',
		dataType 	: 'JSON',
		async 		: false,
		
	// 결과
	}).done(function (result) {
		if (result.status) {
			
			var bankSelect;
			
			// 등록 Modal
			if (type == 'I') {
				bankSelect = '#bankSelect';
				
			// 수정 Modal
			} else if (type == 'U') {
				bankSelect = '#updateBankSelect';
				
			// 검색 Modal
			} else if (type == 'S') {
				bankSelect = '#searchBank';
			}
			
			$(bankSelect).empty();
			
			var bankList = result.list;
			var bankLength = bankList.length;
			var html = '';
			for (var i = 0; i < bankLength; i++) {
				if (type == 'S') {
					
					if (i == 0) {
						html += '<div class="custom-control custom-checkbox small float-left">';
						html += '	<input type="checkbox" class="custom-control-input bank_all_check" value="all" id="bank_all_check' + i + '" checked/>';
						html += '	<label class="custom-control-label" for="bank_all_check' + i + '">전체</label>';
						html += '</div>';
					}
					
					html += '<div class="custom-control custom-checkbox small float-left">';
					html += '	<input type="checkbox" class="custom-control-input bank_data_check" id="bank_data_check' + i + '" value="' + bankList[i].bankIdx + '">';
					html += '	<label class="custom-control-label" for="bank_data_check' + i + '">' + bankList[i].bankName + '</label>';
					html += '</div>';
				} else {
					html += '<option value="' + bankList[i].bankIdx + '">' + bankList[i].bankName + '</option>';
				}
			}
			
			$(bankSelect).append(html);
			
			// 단일 체크
			$('.bank_data_check').change(function () {

				var allChecked = true;
				$('.bank_data_check').each(function () {
					if (!$(this).prop('checked')) {
						allChecked = false;
						return false;
					}
				});
				
				$('.bank_all_check').prop('checked', allChecked);
				
				// 목록 조회
				bankBookList();
			});
			
			// 전체 체크
			$('.bank_all_check').change(function () {
				var thisChecked = $(this).prop('checked');
				$('.bank_data_check').each(function () {
					$(this).prop('checked', thisChecked);
				});
				
				// 목록 조회
				bankBookList();
			});
		}
	});
}

/**
 * 통장 유형 목록 조회 Function
 */
function bankBookTypeList (type) {
	var bankBookTypeSelect;
	
	// 등록
	if (type == 'I') {
		bankBookTypeSelect = '#bankBookTypeSelect';
		
	// 수정
	} else if (type == 'U') {
		bankBookTypeSelect = '#updateBankBookTypeSelect';
	}
	
	$.ajax({
		url 		: '/rest/bankBookType/list',
		method 		: 'POST',
		dataType 	: 'JSON',
		data 		: {},
		success 	: function (result) {
			if (result.status) {
				
				var html = '<option value="">선택</option>';
				var list = result.list;
				var listLength = list.length;
				for (var i = 0; i < listLength; i++) {
					var thisData = list[i];
					html += '<option value="' + thisData.bankBookTypeIdx + '">' + thisData.typeName + '</option>';		
				}
				$(bankBookTypeSelect).empty().append(html);
				
				// 통장 유형 변경시 메인통장 중복 확인
				$(bankBookTypeSelect).off('change').change(function () {
					checkMainBankBook($(this).val(), type);
				});
				
			} else {
				alert('서버 에러');
			}
		}
	});
}

/**
 * 가계통장인지 체크하는 Function
 
 */
function checkMainBankBook (selectIdx, type) {
	
	if (selectIdx == 1) {
		
		// 수정시 현재 수정항목이 가계통장인 경우는 무시
		if (type == 'U' && $('#updateBankBookTypeIdx').val() == 1) {
			return false;
		}
		
		$.ajax({
			url 		: '/rest/bankBook/main',
			method 		: 'POST',
			dataType 	: 'JSON',
			data 		: {},
			success 	: function (result) {
				if (result.status) {
					
					// 상세 정보가 있으면 메인 가계통장 등록 불가
					if (result.detail) {
						alert('가계통장은 이미 사용중이므로 선택할 수 없습니다.');
						$(bankBookTypeSelect).val('');
					}
					
				} else {
					alert('서버 에러');
				}
			}
		});
	}
	
}
</script>

<div class="container-fluid">
	<h4 class="mb-2 text-gray-800">통장 관리</h4>
	
	<!-- search START -->
	<div class="card shadow mb-4">
    	<div class="card-header py-3">
         	<h6 class="m-0 font-weight-bold text-primary">Search</h6>
       	</div>
       	<div class="card-body">
        	<div class="table-responsive">
          		<table class="table">
          			<colgroup>
						<col width="7%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="7%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="auto"/>
					</colgroup>
					<tbody>
						<tr>
							<th>은행명</th>
							<td colspan="8">
								<div id="searchBank">
								</div>
							</td>
						</tr>
						<tr>
							<th>개설일</th>
							<td>
								<input type="text" class="form-control form-control-sm datepicker" id="startDateOpen"/>
							</td>
							<td>
								<input type="text" class="form-control form-control-sm datepicker" id="endDateOpen"/>
							</td>
							<th>만기일</th>
							<td>
								<input type="text" class="form-control form-control-sm datepicker" id="startDateClose"/>
							</td>
							<td>
								<input type="text" class="form-control form-control-sm datepicker" id="endDateClose"/>
							</td>
							<td>
							</td>
						</tr>
					</tbody>
          		</table>
       		</div>
      	</div>
   	</div>
   	<!-- search END -->
      	
     	
    <!-- button START -->
	<div class="top-button-area">
		<span class="total-amount-span float-left">총 잔액 : <span id="totalAmount" class="color-green">0</span></span>
		<button class="btn btn-primary btn-sm float-right" id="insertModalOpenBtn" data-toggle="modal" data-target="#insertModal">등록</button>
		<button class="btn btn-primary btn-sm float-right" type="button" id="searchBtn">검색</button>
	</div>
	<!-- button END -->

	
	<!-- list START -->
    <div class="card shadow mb-4">
	    <div class="card-header py-3">
	      	<h6 class="m-0 font-weight-bold text-primary">통장 목록</h6>
	    </div>
    	<div class="card-body">
          	<div class="table-responsive">
               	<table class="table table-bordered" id="bankBookTable">
               		<colgroup>
						<col width="7%"/>
						<col width="7%"/>
						<col width="15%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="9%"/>
					</colgroup>
               		<thead>
                   		<tr>
							<th class="text-center">유형</th>
							<th class="text-center">사용자</th>
							<th class="text-center">통장명</th>
							<th class="text-center">은행명</th>
							<th class="text-center">계좌번호</th>
							<th class="text-center">잔액</th>
							<th class="text-center">개설일</th>
							<th class="text-center">만기일</th>
							<th class="text-center">상세보기</th>
                   		</tr>
                 	</thead>
               		<tbody>
               		</tbody>
              	</table>	
           	</div>
       	</div>
    </div> 
    <!-- list END --> 	
</div>

<!-- 등록 modal -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="myInsertModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myInsertModalLabel">등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table">
					<tr>
						<th>은행</th>
						<td>
							<select id="bankSelect" class="form-control form-control-sm"></select>
						</td>
					</tr>
					<tr>
						<th>통장명</th>
						<td>
							<input type="text" class="form-control form-control-sm" id="bankBookName"/>
						</td>
					</tr>
					<tr>
						<th>계좌번호</th>
						<td>
							<input type="text" class="form-control form-control-sm" id="acountNumber"/>
						</td>
					</tr>
					<tr>
						<th>통장 유형</th>
						<td>
							<select id="bankBookTypeSelect" class="form-control form-control-sm"></select>
						</td>
					</tr>
					<tr>
						<th>개설일</th>
						<td>
							<input type="text" class="form-control form-control-sm datepicker" id="openDate"/>
						</td>
					</tr>
					<tr>
						<th>만기일</th>
						<td>
							<input type="text" class="form-control form-control-sm datepicker" id="closeDate"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-sm" id="insertBtn">등록</button>
				<button type="button" class="btn btn-secondary btn-sm" id="insertCloseBtn" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
	
<!-- 수정 modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myUpdateModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myUpdateModalLabel"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="updateBankBookIdx" value=""/>
				<input type="hidden" id="updateBankBookTypeIdx" value=""/>
				<table class="table">
					<tr>
						<th>은행</th>
						<td>
							<select id="updateBankSelect" class="form-control form-control-sm"></select>
						</td>
					</tr>
					<tr>
						<th>통장명</th>
						<td>
							<input type="text" class="form-control form-control-sm" id="updateBankBookName"/>
						</td>
					</tr>
					<tr>
						<th>계좌번호</th>
						<td>
							<input type="text" class="form-control form-control-sm" id="updateAcountNumber"/>
						</td>
					</tr>
					<tr>
						<th>통장 유형</th>
						<td>
							<select id="updateBankBookTypeSelect" class="form-control form-control-sm"></select>
						</td>
					</tr>
					<tr>
						<th>금액</th>
						<td>
							<input type="text" class="form-control form-control-sm text-right" id="updateTotalAmount"/>
						</td>
					</tr>
					<tr>
						<th>개설일</th>
						<td>
							<input type="text" class="form-control form-control-sm datepicker" id="updateOpenDate"/>
						</td>
					</tr>
					<tr>
						<th>만기일</th>
						<td>
							<input type="text" class="form-control form-control-sm datepicker" id="updateCloseDate"/>
						</td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger btn-sm" id="deleteBtn">삭제</button>
				<button type="button" class="btn btn-primary btn-sm" id="updateBtn">수정</button>
				<button type="button" class="btn btn-secondary btn-sm" id="updateCloseBtn" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>