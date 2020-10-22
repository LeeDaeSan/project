<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.ds.homes.tools.util.DateUtil"%>
<style>
#checkMemoModal .modal-dialog {
	max-width 		: none !important;
	width 			: 1050px !important;
}
#checkMemoModal #checkMemoAddBtn {
	width 			: 100%;
}
#checkMemoModal .check_memo_btn_area {
	padding-bottom 	: 10px;
	float			: right;
}
#checkMemoModal .check_memo_amount_area {
	float			: left;
    font-size		: 12px;
    padding-top		: 18px;
}
.check-memo-checked {
	text-decoration : line-through;
	color			: #c5c5c5 !important;
}
#todayTimeArea {
	margin-top 	: 38px;
}
#todayArea {
	padding-left : 240px;
}
#todayDiv, #befdayDiv {
	margin-top 	: 18px;
	float		: left;
}
#todayDiv span, #befdayDiv span {
	font-size	: 12px;
    padding-left: 10px;
    color		: #818182;
}
#todayDiv ul, #befdayDiv ul {
	height		: 27px;
	overflow 	: hidden;
	margin		: 0;
	padding		: 0;
	list-style	: none;
	font-size	: 13px;
	color		: black;
}
#todayDiv ul li, #befdayDiv ul li {
	height		: 30px;
	padding		: 5px;
	margin		: 0px 5px;
}
</style>
<script type="text/javascript">
var bkList;
var bkListLength = 0;

$(function () {
	
	dailyCheckMemoHeader();
	
	setInterval(function () {
		tick();
	}, 2000);
	
	// 은행 목록 조회
	$.ajax({
		url 		: '/bank/list',
		data 		: {},
		type 		: 'POST',
		dataType 	: 'JSON',
		async 		: false,
		
	}).done(function (result) {
		bkList 			= result.list;
		bkListLength 	= bkList.length;
	});
	
	// Check List click event
	$('#checkMemoPopupBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		checkMemoInfo();
	});
	
	// Check List add click event
	$('#checkMemoAddBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		// 공백 라인 제거
		$('#checkMemoEmptyTr').remove();
		
		var html  = '<tr class="add_check_tr">';
			html += '	<td class="text-center"><button type="button" class="btn btn-danger btn-sm delete_row_btn">X</button></td>';
			html += '	<td>';
			html += '		<select class="form-control form-control-sm check_bank_select">';
			for (var i = 0; i < bkListLength; i++) {
				var thisData = bkList[i];
				html += '		<option value="' + thisData.bankIdx + '">' + thisData.bankName + '</option>';
			}
			html += '		</select>';
			html += '	</td>';
			html += '	<td><input type="text" class="form-control form-control-sm check_account_number"/></td>';
			html += '	<td><input type="text" class="form-control form-control-sm check_account_holder"/></td>';
			html += '	<td><input type="text" class="form-control form-control-sm check_amount"/></td>';
			html += '	<td>';
			html += '		<select class="form-control form-control-sm check_transfer_type">';
			html += '			<option value="1">자동</option>';
			html += '			<option value="2">수동</option>';
			html += '		</select>';
			html += '	</td>';
			html += '	<td><input type="text" class="form-control form-control-sm check_transfer_date"/></td>';
			html += '	<td><input type="text" class="form-control form-control-sm check_content"/></td>';
			html += '	<td></td>';
			html += '	<td></td>';
			html += '</tr>';
		$('#checkMemoTable tbody').append(html);
		
		// 금액 keyup event
		$('.check_amount').off('keyup').keyup(function (e) {
			e.preventDefault();
			
			var thisData = common.number.onlyNumber($(this).val());
				thisData = common.number.addComma(thisData);
				
			$(this).val(thisData);
		});
		
		// 추가한 row 삭제 event
		$('.delete_row_btn').unbind('click').click(function (e) {
			e.preventDefault();
			
			$(this).closest('tr').remove();
		});
	});
	
	// Check List All Save event
	$('#allSaveBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		var addData = $('#checkMemoTable tbody .add_check_tr, #checkMemoTable tbody .change_check_tr');
		var addDataLength = addData.length;
		
		if (addDataLength == 0) {
			alert('저장할 정보가 없습니다.');
			return false;
			
		} else {
			var addList = {
				type : 'I'
			};
			
			for (var i = 0; i < addDataLength; i++) {
				var thisTr = $(addData[i]);
				
				var checkMemoIdx 	= thisTr.attr('checkMemoIdx');
				var bankIdx 		= thisTr.find('.check_bank_select').val();
				var accountNumber 	= thisTr.find('.check_account_number').val();
				var accountHolder	= thisTr.find('.check_account_holder').val();
				var amount			= thisTr.find('.check_amount').val();
				var content			= thisTr.find('.check_content').val();
				var transferType	= thisTr.find('.check_transfer_type').val();
				var transferDate	= thisTr.find('.check_transfer_date').val();
				
				addList['checkMemoList[' + i + '].checkMemoIdx']	= checkMemoIdx ? checkMemoIdx : 0;
				addList['checkMemoList[' + i + '].bankIdx']			= bankIdx;
				addList['checkMemoList[' + i + '].accountNumber']	= accountNumber;
				addList['checkMemoList[' + i + '].accountHolder']	= accountHolder;
				addList['checkMemoList[' + i + '].amount']			= common.number.onlyNumber(amount);
				addList['checkMemoList[' + i + '].content']			= content;
				addList['checkMemoList[' + i + '].transferType']	= transferType;
				addList['checkMemoList[' + i + '].transferDate']	= transferDate;
			}
			
			if (confirm('변경된 내용을 일괄저장 하시겠습니까?')) {
				
				$.ajax({
					url 		: '/rest/checkMemo/merge',
					dataType	: 'JSON',
					method		: 'POST',
					data		: addList,
					
				}).done(function (result) {
					if (result.status) {
						checkMemoInfo();
					} else {
						alert('저장중 서버 에러가 발생하였습니다.');
					}
					
				}).fail(function (result) {
					alert('저장중 서버 에러가 발생하였습니다.');
				});
			}
		}
		
	});
});

function checkMemoInfo () {
	
	$.ajax({
		url			: '/rest/checkMemo/info',
		method		: 'POST',
		dataType	: 'JSON',
		async		: false,
		
	}).done(function (result) {
		
		if (result.status) {
			var info = result.info;
			
			if (info) {
				
				var checkMemoList 			= info;
				var checkMemoListLength 	= checkMemoList.length;
				var checkMemoTotalAmount 	= 0;
				
				if (checkMemoListLength == 0) {
					$('#checkMemoTable tbody').append('<tr id="checkMemoEmptyTr"><td class="text-center" colspan="10">내용이 없습니다.</td></tr>');
				}
				
				var html = '';
				for (var i = 0; i < checkMemoListLength; i++) {
					var thisData 		= checkMemoList[i];
					var isChecked 		= thisData.isChecked;
					var transferType 	= common.string.toEmpty(thisData.transferType);
					
					html += '<tr class="text-center check_list_info ' + (isChecked == '1' ? 'check-memo-checked' : '') + '" checkMemoIdx="' + thisData.checkMemoIdx + '">';
					html += '	<td class="text-center">';
					html += '		<input class="check_list_checkbox" type="checkbox" isChecked="' + isChecked + '" ' + (isChecked == '1' ? 'checked' : '') + '/>';
					html += '	</td>';
					html += '	<td class="text-left">';
					html += '		<span bankIdx="' + thisData.bank.bankIdx + '">' + (thisData.bank ? thisData.bank.bankName : '') + '</span>';
					html += '	</td>';
					html += '	<td class="text-left">';
					html += '		<span>' + common.string.toEmpty(thisData.accountNumber) + '</span>';
					html += '	</td>';
					html += '	<td>';
					html += '		<span>' + common.string.toEmpty(thisData.accountHolder) + '</span>';
					html += '	</td>';
					html += '	<td class="text-right">';
					html += '		<span>' + common.number.addComma(common.string.toEmpty(thisData.amount)) + '</span>';
					html += '	</td>';
					html += '	<td class="text-center">';
					html += '		<span transferType="' + transferType + '">' + (transferType == '1' ? '자동' : '수동') + '</span>';
					html += '	</td>';
					html += '	<td class="text-right">';
					html += '		<span>' + common.string.toEmpty(thisData.transferDate) + '</span>';
					html += '	</td>';
					html += '	<td class="text-left">';
					html += '		<span>' + common.string.toEmpty(thisData.content) + '</span>';
					html += '	</td>';
					html += '	<td class="text-center">';
					html += '		<button class="btn btn-warning btn-sm check_change_btn">수정</button>';
					html += '		<button class="btn btn-sm check_cancel_btn" style="display:none;">취소</button>';
					html += '	</td>';
					html += '	<td class="text-center"><button class="btn btn-danger btn-sm check_delete_btn">삭제</button></td>';
					html += '</tr>';
					
					checkMemoTotalAmount += thisData.amount;
				}
				
				$('#checkMemoTable tbody').empty().append(html);
				
				// 체크 메모 총 금액
				$('#checkMemoTotalAmount').text(common.number.addComma(checkMemoTotalAmount));
				
				// 체크박스 checked / unchecked
				$('#checkMemoTable tbody .check_list_checkbox').unbind('click').click(function (e) {
					e.preventDefault();
										
					var thisTag 		= $(this);
					var checkMemoIdx 	= thisTag.closest('.check_list_info').attr('checkMemoIdx');
					var isChecked 		= thisTag.attr('isChecked');
						isChecked 		= (isChecked == '0' ? '1' : '0');
						
					$.ajax({
						url			: '/rest/checkMemo/isChecked',
						dataType	: 'JSON',
						method		: 'POST',
						data		: {
							checkMemoIdx 	: checkMemoIdx,
							isChecked		: isChecked
						}						
					
					}).done(function (result) {
						
						if (result.status) {
							
							thisTag.attr('isChecked', isChecked);
							
							if (isChecked == '1') {
								thisTag.prop('checked', true);
								thisTag.closest('.check_list_info').addClass('check-memo-checked');
							} else {
								thisTag.prop('checked', false);
								thisTag.closest('.check_list_info').removeClass('check-memo-checked');
							}
							
						} else {
							alert('서버 에러');
						}
						
					}).fail(function (result) {
						alert('서버 에러');
					});
				});
				
				// row 삭제 button event
				$('#checkMemoTable tbody .check_delete_btn').unbind('click').click(function (e) {
					e.preventDefault();
					
					var checkMemoIdx = $(this).closest('.check_list_info').attr('checkMemoIdx');
					
					if (confirm('선택된 정보를 삭제하시겠습니까?')) {
						
						$.ajax({
							url			: '/rest/checkMemo/delete',
							dataType	: 'JSON',
							method		: 'POST',
							data		: {
								checkMemoIdx : checkMemoIdx
							}
						}).done(function (result) {
							
							if (result.status) {
								checkMemoInfo();
								alert('정보 삭제를 완료하였습니다.');
								
							} else {
								alert('정보 삭제중 에러가 발생하였습니다.');
							}
							
						}).fail(function (result) {
							alert('정보 삭제중 에러가 발생하였습니다.');
						});
					}
				});
				
				// row 수정 button event
				$('#checkMemoTable tbody .check_change_btn').unbind('click').click(function (e) {
					e.preventDefault();
					
					$(this).hide();
					$(this).closest('td').find('.check_cancel_btn').show();
					
					var thisTr = $(this).closest('tr');
					thisTr.addClass('change_check_tr');
					
					/* Bank Tag START */
					var thisBankTag 	= thisTr.find('td:eq(1)');
					var thisBankSpan 	= thisBankTag.find('span');
					var thisBankIdx 	= thisBankSpan.attr('bankIdx');
					var bankHtml  = '<select class="form-control form-control-sm check_bank_select">';
					for (var i = 0; i < bkListLength; i++) {
						var thisData = bkList[i];
						bankHtml += '	<option value="' + thisData.bankIdx + '" ' + (thisData.bankIdx == thisBankIdx ? 'selected' : '') + '>' + thisData.bankName + '</option>';
					}
						bankHtml += '</select>';
					thisBankTag.append(bankHtml);
					thisBankSpan.hide();
					/* Bank Tag END */
					
					/* 계좌번호 Tag START */
					var thisAccountNumberTag 	= thisTr.find('td:eq(2)');
					var thisAccountNumberSpan 	= thisAccountNumberTag.find('span');
					var thisAccountNumber 		= thisAccountNumberSpan.text();
					thisAccountNumberTag.append('<input type="text" class="form-control form-control-sm check_account_number" value="' + thisAccountNumber + '"/>');
					thisAccountNumberSpan.hide();
					/* 계좌번호 Tag END */
					
					/* 예금주 Tag START */
					var thisAccountHolderTag 	= thisTr.find('td:eq(3)');
					var thisAccountHolderSpan	= thisAccountHolderTag.find('span');
					var thisAccountHolder		= thisAccountHolderSpan.text();
					thisAccountHolderTag.append('<input type="text" class="form-control form-control-sm check_account_holder" value="' + thisAccountHolder + '"/>');
					thisAccountHolderSpan.hide();
					/* 예금주 Tag END */
					
					/* 금액 Tag START */
					var thisAmountTag 		= thisTr.find('td:eq(4)');
					var thisAmountSpan		= thisAmountTag.find('span');
					var thisAmount			= thisAmountSpan.text();
					thisAmountTag.append('<input type="text" class="form-control form-control-sm check_amount" value="' + thisAmount + '"/>');
					thisAmountSpan.hide();
					/* 금액 Tag END */
					
					/* 이체유형 Tag START */
					var thisTransferTypeTag 	= thisTr.find('td:eq(5)');
					var thisTransferTypeSpan 	= thisTransferTypeTag.find('span');
					var thisTransferType		= thisTransferTypeSpan.attr('transferType');
					var transferTypeHtml  = '<select class="form-control form-control-sm check_transfer_type">';
						transferTypeHtml += '	<option value="1" ' + (thisTransferType == 1 ? 'selected' : '') + '>자동</option>';
						transferTypeHtml += '	<option value="2" ' + (thisTransferType == 2 ? 'selected' : '') + '>수동</option>';
						transferTypeHtml += '</select>';
					thisTransferTypeTag.append(transferTypeHtml);
					thisTransferTypeSpan.hide();
					/* 이체유형 Tag END */
					
					/* 이체일 Tag START */
					var thisTransferDateTag 	= thisTr.find('td:eq(6)');
					var thisTransferDateSpan	= thisTransferDateTag.find('span');
					var thisTransferDate		= thisTransferDateSpan.text();
					thisTransferDateTag.append('<input type="text" class="form-control form-control-sm check_transfer_date" value="' + thisTransferDate + '"/>');
					thisTransferDateSpan.hide();
					/* 이체일 Tag END */
					
					/* 내용 Tag START */
					var thisContentTag 	= thisTr.find('td:eq(7)');
					var thisContentSpan = thisContentTag.find('span');
					var thisContent		= thisContentSpan.text();
					thisContentTag.append('<input type="text" class="form-control form-control-sm check_content" value="' + thisContent + '"/>');
					thisContentSpan.hide();
					/* 내용 Tag END */
				});
				
				// row 취소 button event
				$('#checkMemoTable tbody .check_cancel_btn').unbind('click').click(function (e) {
					e.preventDefault();
					
					$(this).hide();
					$(this).closest('td').find('.check_change_btn').show();
					
					var thisTr = $(this).closest('tr');
					thisTr.removeClass('change_check_tr');
					
					/* Bank Tag START */
					var thisBankTag = thisTr.find('td:eq(1)');
					thisBankTag.find('.check_bank_select').remove();
					thisBankTag.find('span').show();
					/* Bank Tag END */
					
					/* 계좌번호 Tag START */
					var thisAccountNumberTag = thisTr.find('td:eq(2)');
					thisAccountNumberTag.find('.check_account_number').remove();
					thisAccountNumberTag.find('span').show();
					/* 계좌번호 Tag END */
					
					/* 예금주 Tag START */
					var thisAccountHolderTag = thisTr.find('td:eq(3)');
					thisAccountHolderTag.find('.check_account_holder').remove();
					thisAccountHolderTag.find('span').show();
					/* 예금주 Tag END */
					
					/* 금액 Tag START */
					var thisAmountTag = thisTr.find('td:eq(4)');
					thisAmountTag.find('.check_amount').remove();
					thisAmountTag.find('span').show();
					/* 금액 Tag END */
					
					/* 이체유형 Tag START */
					var thisTransferTypeTag = thisTr.find('td:eq(5)');
					thisTransferTypeTag.find('.check_transfer_type').remove();
					thisTransferTypeTag.find('span').show();
					/* 이체유형 Tag END */
					
					/* 이체일 Tag START */
					var thisTransferDateTag = thisTr.find('td:eq(6)');
					thisTransferDateTag.find('.check_transfer_date').remove();
					thisTransferDateTag.find('span').show();
					/* 이체일 Tag END */
					
					/* 내용 Tag START */
					var thisContentTag = thisTr.find('td:eq(7)');
					thisContentTag.find('.check_content').remove();
					thisContentTag.find('span').show();
					/* 내용 Tag END */
				});
			}
			
		} else {
			alert('서버 에러');
		}
	});
}

function dailyCheckMemoHeader () {
	
	$.ajax({
		url			: '/rest/dashboard/checkMemo/daily',
		method		: 'POST',
		dataType	: 'JSON',
		async		: false,
		data		: {}
	
	}).done(function (result) {
		if (result.status) {
		
			// 목록 초기화
			$('#todayDiv ul, #befdayDiv ul').empty();
			
			var todayList 		= result.todayList;
			var todayListLength = todayList.length;
			for (var i = 0; i < todayListLength; i++) {
				var thisData = todayList[i];
				var html = '<li>' + thisData.bank.bankName + ' | ' + thisData.accountNumber + ' | ' + common.number.addComma(thisData.amount) + ' | ' + thisData.content + '</li>';				
				$('#todayDiv ul').append(html);
			}		
			if (todayListLength == 0) {
				$('#todayDiv ul').append('<li>납입할 내역이 없습니다.</li>');
			}
			
			var befdayList 			= result.befdayList;
			var befdayListLength 	= befdayList.length;
			for (var i = 0; i < befdayListLength; i++) {
				var thisData = befdayList[i];
				var html = '<li>' + thisData.transferDate + '일 | ' + thisData.bank.bankName + ' | ' + thisData.accountNumber + ' | ' + common.number.addComma(thisData.amount) + ' | ' + thisData.content + '</li>';
				$('#befdayDiv ul').append(html);
			}
			if (befdayListLength == 0) {
				$('#befdayDiv ul').append('<li>납입할 내역이 없습니다.</li>');
			}
		}
		
	}).fail(function (result) {
		alert('서버 에러');
	});
}

function tick () {
	if ($('#todayDiv ul li').length > 1) {
		$('#todayDiv ul li:first').slideUp(function () {
			$(this).appendTo($('#todayDiv ul')).slideDown();
		});
	}
	if ($('#befdayDiv ul li').length > 1) {
		$('#befdayDiv ul li:first').slideUp(function () {
			$(this).appendTo($('#befdayDiv ul')).slideDown();
		});
	}
}
</script>
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
	<div id="todayTimeArea"><%= DateUtil.dateToString(new Date(), "yyyy년 MM월 dd일, EEE요일") %></div>
	<div id="todayArea">
		<div id="todayDiv">
			<span>금일 납입 예정 내역</span>
			<ul></ul>
		</div>
		<div id="befdayDiv">
			<span>지난 미납 내역</span>
			<ul></ul>
		</div>
	</div>
	<ul class="navbar-nav ml-auto">
		<li class="nav-item dropdown no-arrow">
	      	<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	        	<span class="mr-2 d-none d-lg-inline text-gray-600 small">Valerie Luna</span>
	      	</a>
	      	<!-- Dropdown - User Information -->
	      	<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
	        	<a class="dropdown-item" href="#">
	          		<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
	          		Profile
	          	</a>
	        	<a class="dropdown-item" href="javascript:void(0);" id="checkMemoPopupBtn" data-toggle="modal" data-target="#checkMemoModal">
	          		<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
	          		Check List
	          	</a>
	        	<div class="dropdown-divider"></div>
	        	<a class="dropdown-item" href="/logout">
	          		<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
	          		Logout
	        	</a>
	      	</div>
	    </li>
	</ul>
</nav>

<!-- Check List Popup START -->
<div class="modal fade" id="checkMemoModal" tabindex="-1" role="dialog" aria-labelledby="myCheckMemoModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myCheckMemoModalLabel"><span id="checkMemoPopupTitle"></span> Check List</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="check_memo_amount_area">
					총 금액 : <span id="checkMemoTotalAmount" class="color-red">0</span>
				</div>
				<div class="check_memo_btn_area">
					<button type="button" class="btn btn-sm btn-warning">초기화</button>
					<button type="button" class="btn btn-sm btn-primary" id="allSaveBtn">일괄저장</button>
				</div>
				<div class="table-responsive">
					<table class="table" id="checkMemoTable">
						<colgroup>
							<col width="5%"/>
							<col width="10%"/>
							<col width="15%"/>
							<col width="10%"/>
							<col width="12%"/>
							<col width="10%"/>
							<col width="7%"/>
							<col width="auto"/>
							<col width="7%"/>
							<col width="7%"/>
						</colgroup>
						<thead>
							<tr>
								<th class="text-center"></th>
								<th class="text-center">은행</th>
								<th class="text-center">계좌번호</th>
								<th class="text-center">예금주</th>
								<th class="text-center">금액</th>
								<th class="text-center">이체유형</th>
								<th class="text-center">이체일</th>
								<th class="text-center">내용</th>
								<th class="text-center">수정</th>
								<th class="text-center">삭제</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
						<tfoot>
							<tr>
								<td class="text-center" colspan="10"><button type="button" class="btn btn-primary" id="checkMemoAddBtn">+</button></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Check List Popup END -->