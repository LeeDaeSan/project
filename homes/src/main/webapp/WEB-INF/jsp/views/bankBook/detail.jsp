<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.total-count-div{padding-top:13px;}
.count-content-div{padding-top:13px;padding-left:10px;}
.button-div{margin-bottom:5px;height:30px;}
table{border-top:1px solid #dddddd;border-bottom:1px solid #dddddd;}
.hyphen-span{line-height:30px;padding-left:2px;}
.search_amount_input, .search_amount_date_input{width:110px !important;}
.category1_select, .category2_select, .category3_select{width:110px !important;margin-right:10px;}
#saveDataBtn, #deleteDataBtn{margin-right:5px;}

</style>

<script type="text/javascript">
const bankBookIdx = '${param.idx}';
var page = 1;
var limit = 10;

$(function () {

	// 검색창 분류1
	$('#searchCategory1').empty().append(categoryList(1, null));
	// 분류1 변경시 분류2 목록 호출
	$('#searchCategory1').change(function () {
		$('#searchCategory2').empty().append(categoryList(2, $(this).val()));	
		$('#searchCategory3').empty().append(categoryList(3, null));
	});
	// 분류2 변경시 분류3 목록 호출
	$('#searchCategory2').change(function () {
		$('#searchCategory3').empty().append(categoryList(3, $(this).val()));
	});
	
	// datepicker
	$('.datepicker').datepicker({
		format 		: 'yyyy-mm-dd',		// 포맷 형식
		autoclose 	: true,				// 날짜 선택시 자동 close
	});
	
	// 분류1
	
	// 검색
	$('#searchBtn').unbind('click').click(function (e) {
		e.preventDefault();
		// 목록 조회
		list();
	});
	
	// 최초 목록 조회
	$('#searchBtn').click();
	
	// 유형 변경 검색
	$('.search_amount_type_select').change(function () {
		$('#searchBtn').click();
	});
	
	// 검색창 금액 keyup event
	$('.search_amount_input').off('keyup').keyup(function (e) {
		e.preventDefault();
		
		var thisData = common.number.onlyNumber($(this).val());
			thisData = common.number.addComma(thisData);

		$(this).val(thisData);
	});
	
	// 비고 keyup enter event
	$('.search_content_input').off('keyup').keyup(function (e) {
		if (e.keyCode == '13') {
			$('#searchBtn').click();
		}
	});
	// 추가하기 button event
	$('#addDataBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		var tableTbodyTag = $('#bankBookDetailTable tbody');
		
		tableTbodyTag.find('tr').each(function () {
			if ($(this).hasClass('data_empty')) {
				$(this).remove();
				return false;
			}
		});
		
		var html  = '<tr class="add_data_tr">';
			html += '	<td class="text-center">';
			html += '		<button type="button" class="btn btn-danger btn-sm remove_data">x</button>';
			html += '	</td>';
			
						/* 유형 태그 START */
			html += '	<td>';
			html += '		<select class="form-control amount_type_select">';
			html += '			<option value="IN">입금</option>';
			html += '			<option value="OUT">출금</option>';
			html += '		</select>';
			html += '	</td>';
						/* 유형 태그 END */
						
						/* 카테고리1 태그 START */
			html += '	<td>';		
			html += '		<select class="form-control category1_select">';
			html += 			categoryList(1, null);
			html += '		</select>';
			html += '	</td>';
						/* 카테고리1 태그 END */
						
						/* 카테고리2 태그 START */
			html += '	<td>';		
			html += '		<select class="form-control category2_select">';
			html += '			<option value="">선택없음</option>';
			html += '		</select>';
			html += '	</td>';
						/* 카테고리2 태그 END */
						
						/* 카테고리3 태그 START */
			html += '	<td>';		
			html += '		<select class="form-control category3_select">';
			html += '			<option value="">선택없음</option>';
			html += '		</select>';
			html += '	</td>';
						/* 카테고리3 태그 END */
						
						/* 금액 태그 START */
			html += '	<td>';		
			html += '		<input type="text" class="form-control amount_input text-right" maxLength="15"/>';
			html += '	</td>';
						/* 금액 태그 END */
						
						/* 입출금 일자 태그 START */
			html += '	<td>';		
			html += '		<input type="text" class="form-control amount_date_input datepicker text-center"/>';
			html += '	</td>';
						/* 입출금 일자 태그 END */
						
						/* 비고 태그 START */
			html += '	<td>';		
			html += '		<input type="text" class="form-control content_input"/>';
			html += '	</td>';
						/* 비고 태그 END */
						
			html += '	<td></td>';
			html += '</tr>';
		tableTbodyTag.prepend(html);
		
		// 선택 행 삭제하기
		$('.remove_data').unbind('click').click(function (e) {
			e.preventDefault();
			if (confirm('선택한 행을 삭제하시겠습니까?')) {
				$(this).closest('.add_data_tr').remove();
				
				if (tableTbodyTag.find('tr').length == 0) {
					tableTbodyTag.append('<tr class="data_empty"><td colspan="8" class="text-center">정보가 없습니다.</td></tr>');
				}
			}
		});
		
		// 카테고리1 select box event
		$('.add_data_tr .category1_select').off('change').change(function (e) {
			e.preventDefault();
			$(this).closest('tr').find('.category2_select')
					.empty().append( categoryList(2, $(this).val()) );
			$(this).closest('tr').find('.category3_select')
					.empty().append( categoryList(3, null) );
		});
		
		// 카테고리2 select box event
		$('.add_data_tr .category2_select').off('change').change(function (e) {
			e.preventDefault();
			
			$(this).closest('tr').find('.category3_select')
					.empty().append( categoryList(3, $(this).val()) );
		});
		
		// 금액 keyup event
		$('.add_data_tr .amount_input').off('keyup').keyup(function (e) {
			e.preventDefault();
			
			var thisData = common.number.onlyNumber($(this).val());
				thisData = common.number.addComma(thisData);

			$(this).val(thisData);
		});
		
		$('.datepicker').datepicker('destroy');
		
		$('.datepicker').datepicker({
			format 		: 'yyyy-mm-dd',		// 포맷 형식
			autoclose 	: true,				// 날짜 선택시 자동 close
		});
		
	});
	
	// 저장하기
	$('#saveDataBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		var addData = $('#bankBookDetailTable tbody tr.add_data_tr');
		var addDataLength = addData.length;
		
		// 추가 데이터가 없을 때
		if (addDataLength == 0) {
			alert('추가한 정보가 없습니다.');
			return false;
			
		} else {
			
			var addList = {
				type : 'I'
			};
			
			for (var i = 0; i < addDataLength; i++) {
				var thisTr = $(addData[i]);
				
				var amountType 		= thisTr.find('.amount_type_select').val();
				var category1Idx 	= thisTr.find('.category1_select').val();
				var category2Idx 	= thisTr.find('.category2_select').val();
				var category3Idx 	= thisTr.find('.category3_select').val();
				var amount 			= thisTr.find('.amount_input').val();
				var amountDate		= thisTr.find('.amount_date_input').val();
				var content			= thisTr.find('.content_input').val();
				
				// 카테고리1 validation
				if (!category1Idx) {
					alert('분류1 항목을 선택해 주세요.');
					return false;
				}
				
				// 금액 validation
				if (!amount) {
					alert('금액 항목을 입력해 주세요.');
					return false;
				}
				
				// 입출금 일자 validation
				if (!amountDate) {
					alert('입출금 일자를 입력해 주세요.');
					return false;
				}
				
				addList['bankBookDetailList[' + i + '].bankBookIdx'] 	= bankBookIdx;
				addList['bankBookDetailList[' + i + '].amountType'] 	= amountType;
				addList['bankBookDetailList[' + i + '].category1Idx'] 	= category1Idx;
				addList['bankBookDetailList[' + i + '].category2Idx'] 	= category2Idx;
				addList['bankBookDetailList[' + i + '].category3Idx'] 	= category3Idx;
				addList['bankBookDetailList[' + i + '].amount'] 		= common.number.onlyNumber(amount);
				addList['bankBookDetailList[' + i + '].amountDateStr'] 	= amountDate;
				addList['bankBookDetailList[' + i + '].content'] 		= content;
			}
			
			$.ajax({
				url 		: '/rest/bankBookDetail/change',
				method 		: 'POST',
				dataType 	: 'JSON',
				data 		: addList,
				success 	: function (result) {
					if (result.status) {
						location.reload();
					}
				}
			});
		}
	});
	
	// 삭제하기
	$('#deleteDataBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		var checkedLength = $('#bankBookDetailTable tbody tr .list_checkbox:checked').length;
		
		// 선택 항목이 없을 때
		if (checkedLength == 0) {
			alert('선택된 항목이 없습니다.\n선택 후 다시 시도해 주시기 바랍니다.');
			
		// 선택 항목이 있을 때
		} else {

			if (confirm('선택된 항목들을 삭제하시겠습니까?')) {
				var removeList = {
					type : 'D'
				};
				
				$('#bankBookDetailTable tbody tr').each(function (i) {
					if ($(this).find('.list_checkbox').prop('checked')) {
						removeList['bankBookDetailList[' + i + '].bankBookIdx'] 		= $(this).attr('bankBookIdx');
						removeList['bankBookDetailList[' + i + '].bankBookDetailIdx'] 	= $(this).attr('idx');
						removeList['bankBookDetailList[' + i + '].amount'] 				= common.number.onlyNumber($(this).find('td:eq(5)').text());
						removeList['bankBookDetailList[' + i + '].amountType'] 			= $(this).find('td:eq(1)').text() == '입금' ? 'IN' : 'OUT';
					}
				});
				
				$.ajax({
					url 		: '/rest/bankBookDetail/change',
					method 		: 'POST',
					dataType 	: 'JSON',
					data 		: removeList,
					success 	: function (result) {
						if (result.status) {
							alert('선택된 항목을 삭제 완료하였습니다.');
							location.reload();
						} else {
							alert('서버 에러');
						}
					}
				});
			}
		}
	});
});

/**
 * 가계 상세 정보 목록 조회 Function
 *
 */
function list (page) {
	if (!page) {
		page = 1;
	}
	var thisList = list;
	
	$.ajax({
		url 		: '/rest/bankBookDetail/list',
		method 		: 'POST',
		dataType 	: 'JSON',
		async		: false,
		data 		: {
			bankBookIdx 	: bankBookIdx,
			amountType 		: $('.search_amount_type_select').val(),
			startAmount 	: common.number.onlyNumber($('#searchStartAmount').val()),
			endAmount 		: common.number.onlyNumber($('#searchEndAmount').val()),
			startDateStr1 	: $('#searchStartDate').val(),
			endDateStr1		: $('#searchEndDate').val(),
			content 		: $('.search_content_input').val(),
			category1Idx 	: $('#searchCategory1').val(),
			category2Idx 	: $('#searchCategory2').val(),
			category3Idx 	: $('#searchCategory3').val(),
			page 			: (page * limit - limit),
			limit 			: limit,
		}
			
	}).done(function (result) {
		if (result.status) {
			
			// 목록 초기화
			$('#bankBookDetailTable tbody').empty();
			// 목록의 total count
			var totalCount = result.totalCount;
			// 목록 전체 수
			$('#totalCount').text(
					common.number.addComma(totalCount));
			// 통장의 총 잔액
			$('#totalAmount').text(
					common.number.addComma(result.bankBook.totalAmount));
			
			var inTotalAmount 	= 0;
			var outTotalAmount 	= 0;
			
			var list = result.list;
			var listLength = list.length;
			for (var i = 0; i < listLength; i++) {
				var thisData = list[i];
				
				var amountType = thisData.amountType;
				var colorType = amountType == 'IN' ? 'color-blue' : 'color-red';
				
				if (amountType == 'IN') {
					inTotalAmount += thisData.amount;
				} else if (amountType == 'OUT') {
					outTotalAmount += thisData.amount;
				}
				
				var html  = '<tr idx="' + thisData.bankBookDetailIdx + '" bankBookIdx="' + thisData.bankBookIdx + '">';
					html += '	<td class="text-center"><input type="checkbox" class="list_checkbox"/></td>';
					html += '	<td class="text-center amount_type" amountType="' + thisData.amountType + '">' + (amountType == 'IN' ? '입금' : '출금') + '</td>';
					html += '	<td>' + ( thisData.category1 ? thisData.category1.categoryName : '' )+ '</td>';
					html += '	<td>' + ( thisData.category2 ? thisData.category2.categoryName : '' ) + '</td>';
					html += '	<td>' + ( thisData.category3 ? thisData.category3.categoryName : '' ) + '</td>';
					html += '	<td class="text-right ' + colorType + '">' + common.number.addComma(thisData.amount) + '</td>';
					html += '	<td class="text-center">' + common.date.toString(new Date(thisData.amountDate), '-') + '</td>';
					html += '	<td>' + (thisData.content ? thisData.content : '') + '</td>';
					html += '	<td class="text-center">';
					html += '		<button type="button" class="btn btn-sm btn-warning update_btn">수정</button>';
					html += '		<button type="button" class="btn btn-sm btn-primary save_btn" style="display:none;">저장</button>';
					html += '		<button type="button" class="btn btn-sm btn-default cancel_btn" style="display:none;">취소</button>';
					html += '	</td>';
					html += '</tr>';
					
				$('#bankBookDetailTable tbody').append(html);
			}

			// 검색 데이터의 입금 총액
			$('#inTotalAmount').text(common.number.addComma(inTotalAmount));
			// 검색 데이터의 출금 총액
			$('#outTotalAmount').text(common.number.addComma(outTotalAmount));
			
			// paging
			common.paging(page, limit, 10, totalCount, thisList);

			// 데이터가 없을 때
			if (listLength == 0) {
				var html = '<tr class="data_empty"><td colspan="9" class="text-center">정보가 없습니다.</td></tr>';
				$('#bankBookDetailTable tbody').append(html);
			}
			
			// 목록 전체 체크
			$('#listAllCheck').change(function (e) {
				var isChecked = $(this).prop('checked');	
				$('#bankBookDetailTable tbody tr .list_checkbox').each(function () {
					$(this).prop('checked', isChecked);
				});
			});
			
			// 수정하기 (수정모드 변경)
			$('.update_btn').unbind('click').click(function (e) {
				e.preventDefault();
				var thisTr = $(this).closest('tr');
				
				// 수정 hide
				$(this).hide();
				// 저장, 취소 show
				thisTr.find('.save_btn, .cancel_btn').show();
				
				$.ajax({
					url 		: '/rest/bankBookDetail/detail',
					method 		: 'POST',
					dataType 	: 'JSON',
					async		: false,
					data 		: {
						bankBookDetailIdx : thisTr.attr('idx')
					},
					success 	: function (result) {
						if (result.status) {
							var detail = result.detail;
							
							/* 유형 START */
							var html  = '		<select class="form-control amount_type_select">';
								html += '			<option value="IN" ' + (detail.amountType == 'IN' ? 'selected' : '') + '>입금</option>';
								html += '			<option value="OUT" ' + (detail.amountType == 'OUT' ? 'selected' : '') + '>출금</option>';
								html += '		</select>';
							thisTr.find('td:eq(1)').empty().append(html);
							/* 유형 END */
							
							/* 분류1 START */
								html  = '		<select class="form-control category1_select">';
								html += 			categoryList(1, null);
								html += '		</select>';
							thisTr.find('td:eq(2)').empty().append(html);
							thisTr.find('td:eq(2) .category1_select').val(detail.category1Idx);
							/* 분류1 END */
							
							/* 분류2 START */
								html  = '		<select class="form-control category2_select">';
								html += 			categoryList(2, detail.category1Idx);
								html += '		</select>';
							thisTr.find('td:eq(3)').empty().append(html);
							thisTr.find('td:eq(3) .category2_select').val(detail.category2Idx);
							/* 분류2 END */
							
							/* 분류3 START */
								html  = '		<select class="form-control category3_select">';
								html += 			categoryList(3, detail.category2Idx);
								html += '		</select>';
							thisTr.find('td:eq(4)').empty().append(html);
							thisTr.find('td:eq(4) .category3_select').val(detail.category3Idx);
							/* 분류3 END */
							
							/* 금액 START */
								html = '<input type="text" class="form-control amount_input text-right" value="' + common.number.addComma(detail.amount) + '" maxLength="15"/>';
							thisTr.find('td:eq(5)').empty().append(html);
							/* 금액 END */
							
							/* 입출금일 START */
								html = '<input type="text" class="form-control amount_date_input datepicker text-center" value="' + common.date.toString(new Date(detail.amountDate), '-') + '"/>';
							thisTr.find('td:eq(6)').empty().append(html);
							/* 입출금일 END */
							
							/* 비고 START */
								html = '<input type="text" class="form-control content_input" value="' + detail.content + '"/>';
							thisTr.find('td:eq(7)').empty().append(html);
							/* 비고 END */
							
							// 카테고리1 select box event
							thisTr.find('.category1_select').off('change').change(function (e) {
								e.preventDefault();
								
								$(this).closest('tr').find('.category2_select')
										.empty().append( categoryList(2, $(this).val()) );
								$(this).closest('tr').find('.category3_select')
										.empty().append( categoryList(3, null) );
							});
							
							// 카테고리2 select box event
							thisTr.find('.category2_select').off('change').change(function (e) {
								e.preventDefault();
								
								$(this).closest('tr').find('.category3_select')
										.empty().append( categoryList(3, $(this).val()) );
							});
							
							// 금액 keyup event
							thisTr.find('.amount_input').off('keyup').keyup(function (e) {
								e.preventDefault();
								
								var thisData = common.number.onlyNumber($(this).val());
									thisData = common.number.addComma(thisData);

								$(this).val(thisData);
							});
							
							$('.datepicker').datepicker('destroy');
							
							$('.datepicker').datepicker({
								format 		: 'yyyy-mm-dd',		// 포맷 형식
								autoclose 	: true,				// 날짜 선택시 자동 close
							});
							
							// 저장하기 (수정)
							thisTr.find('.save_btn').unbind('click').click(function (e) {
								e.preventDefault();
								
								$.ajax({
									url 		: '/rest/bankBookDetail/change',
									method 		: 'POST',
									dataType 	: 'JSON',
									async 		: false,
									data 		: {
										type 	: 'U',
										
										// 변경전 상세 정보
										'befBankBookDetail.amount' 				: detail.amount,
										'befBankBookDetail.amountType' 			: detail.amountType,
										// 변경후 상세 정보
										'aftBankBookDetail.bankBookDetailIdx' 	: detail.bankBookDetailIdx,
										'aftBankBookDetail.bankBookIdx'			: detail.bankBookIdx,
										'aftBankBookDetail.amountType'			: thisTr.find('.amount_type_select').val(),
										'aftBankBookDetail.category1Idx'		: thisTr.find('.category1_select').val(),
										'aftBankBookDetail.category2Idx'		: thisTr.find('.category2_select').val(),
										'aftBankBookDetail.category3Idx'		: thisTr.find('.category3_select').val(),
										'aftBankBookDetail.amount'				: common.number.onlyNumber(thisTr.find('.amount_input').val()),
										'aftBankBookDetail.amountDateStr'		: thisTr.find('.amount_date_input').val(),
										'aftBankBookDetail.content'				: thisTr.find('.content_input').val()
									},
									success 	: function (result) {
										if (result.status) {
											alert('정보를 수정 완료하였습니다.');
											
											thisTr.find('td:eq(1)').text(thisTr.find('.amount_type_select').val() == 'IN' ? '입금' : '출금');
											thisTr.find('td:eq(2)').text(thisTr.find('.category1_select option:selected').text());
											thisTr.find('td:eq(3)').text(thisTr.find('.category2_select option:selected').text());
											thisTr.find('td:eq(4)').text(thisTr.find('.category3_select option:selected').text());
											thisTr.find('td:eq(5)').text(common.number.onlyNumber(thisTr.find('.amount_input').val()));
											thisTr.find('td:eq(6)').text(thisTr.find('.amount_date_input').val());
											thisTr.find('td:eq(7)').text(thisTr.find('.content_input').val());
											
											// 저장, 취소 hide
											thisTr.find('.save_btn, .cancel_btn').hide();
											// 수정 show
											thisTr.find('.update_btn').show();
											
										} else {
											alert('서버 에러');
										}
									}
								});
							});
							
							// 취소하기
							thisTr.find('.cancel_btn').unbind('click').click(function (e) {
								e.preventDefault();
								
								thisTr.find('td:eq(1)').text(detail.amountType == 'IN' ? '입금' : '출금');
								thisTr.find('td:eq(2)').text(detail.category1.categoryName);
								thisTr.find('td:eq(3)').text(detail.category2 ? detail.category2.categoryName : '');
								thisTr.find('td:eq(4)').text(detail.category3 ? detail.category3.categoryName : '');
								thisTr.find('td:eq(5)').text(common.number.addComma(detail.amount));
								thisTr.find('td:eq(6)').text(common.date.toString(new Date(detail.amountDate), '-'));
								thisTr.find('td:eq(7)').text((detail.content ? detail.content : ''));
								
								// 저장, 취소 hide
								thisTr.find('.save_btn, .cancel_btn').hide();
								// 수정 show
								thisTr.find('.update_btn').show();
							});
						}
					}
				});
			});
			
		} else {
			alert('서버 에러');
		}
	});
}

/**
 * 카테고리 목록 조회 Function
 *
 */
function categoryList (level, parentIdx) {
	var html = '';
	$.ajax({
		url 		: '/rest/category/list',
		method 		: 'POST',
		dataType 	: 'JSON',
		async		: false,
		data		: {
			level 		: level,
			parentIdx 	: parentIdx,
		},
		success 	: function (result) {
			if (result.status) {
				
				var list = result.list;
				var listLength = list.length;
				
				if (listLength == 0) {
					html = '<option value="">선택없음</option>';
					
				} else {
					html = '<option value="">선택</option>';
				}
				
				for (var i = 0; i < listLength; i++) {
					var thisData = list[i];
					html += '<option value="' + thisData.categoryIdx + '">' + thisData.categoryName + '</option>';
				}
			}
		}
	});
	
	return html;
} 

</script>
<div class="col-md-12" style="height:20px;">
</div>
<div class="col-md-12">
	<div class="float-right total-amount-div">
		* 통장 총 잔액 : <span id="totalAmount" class="color-green">0</span>
	</div>
</div>
<!-- search 영역 -->
<div class="col-md-12">
	<table class="table">
		<colgroup>
			<col width="7%"/>
			<col width="10%"/>
			<col width="7%"/>
			<col width="20%"/>
			<col width="7%"/>
			<col width="20%"/>
			<col width="auto"/>
		</colgroup>
		<thead>
			<tr><th colspan="7">Search</th></tr>
		</thead>
		<tbody>
			<tr>
				<th class="text-right">유형</th>
				<td>
					<select class="form-control search_amount_type_select">
						<option value="ALL">전체</option>
						<option value="IN">입금</option>
						<option value="OUT">출금</option>
					</select>
				</td>
				<th class="text-right">금액</th>
				<td>
					<input type="text" class="form-control search_amount_input text-right float-left" id="searchStartAmount" value="0" maxLength="15"/>
					<span class="hyphen-span">-</span>
					<input type="text" class="form-control search_amount_input text-right float-right" id="searchEndAmount" value="0" maxLength="15"/>
				</td>
				<th class="text-right">입출금 일자</th>
				<td>
					<input type="text" class="form-control search_amount_date_input datepicker float-left" id="searchStartDate"/>
					<span class="hyphen-span">-</span>
					<input type="text" class="form-control search_amount_date_input datepicker float-right" id="searchEndDate"/>
				</td>
				<td></td>
			</tr>
			<tr>
				<th class="text-right">비고</th>
				<td colspan="3">
					<input type="text" class="form-control search_content_input"/>
				</td>
				<th class="text-right">분류</th>
				<td colspan="2">
					<select class="form-control category1_select float-left" id="searchCategory1">
						<option value="">선택없음</option>
					</select>
					<select class="form-control category2_select float-left" id="searchCategory2">
						<option value="">선택없음</option>
					</select>
					<select class="form-control category3_select float-left" id="searchCategory3">
						<option value="">선택없음</option>
					</select>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="7" class="text-center">
					<button type="button" class="btn btn-primary btn-sm" id="searchBtn">Search</button>
				</td>
			</tr>
		</tfoot>
	</table>
</div>

<!-- list 영역 -->
<div class="col-md-12">
	<div class="float-left count-content-div">
		<span>
			전체 : <span id="totalCount">0</span>
		</span>
		<span><b>|</b></span>
		<span>
			입금 총액 : <span id="inTotalAmount" class="color-blue">0</span>
		</span>
		<span><b>|</b></span>
		<span>
			출금 총액 : <span id="outTotalAmount" class="color-red">0</span>
		</span>
	</div>
	<div class="button-div">
		<button type="button" id="addDataBtn" 		class="btn btn-primary btn-sm float-right">추가하기</button>
		<button type="button" id="saveDataBtn" 		class="btn btn-primary btn-sm float-right">저장</button>
		<button type="button" id="deleteDataBtn" 	class="btn btn-danger btn-sm float-right">삭제</button>
	</div>
</div>

<div class="col-md-12">
	<table id="bankBookDetailTable" class="table table-responsive-md">
		<colgroup>
			<col width="3%"/>
			<col width="7%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="20%"/>
			<col width="10%"/>
		</colgroup>
		<thead>
			<tr>
				<th class="text-center"><input type="checkbox" id="listAllCheck"/></th>
				<th class="text-center">유형</th>
				<th class="text-center">분류1</th>
				<th class="text-center">분류2</th>
				<th class="text-center">분류3</th>
				<th class="text-center">금액</th>
				<th class="text-center">입출금일</th>
				<th class="text-center">비고</th>
				<th class="text-center">수정</th>
			</tr>
		</thead>
		<tbody>
			<tr class="data_empty">
				<td colspan="9" class="text-center">정보가 없습니다.</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="9" class="text-center">
					<ul id="pagination" class="pagination">
					</ul>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
