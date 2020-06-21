<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#checkMemoDiv{
	padding			: 5px;
	top 			: 55px;
	left 			: -300px;
	width			: 300px;
    height			: 100%;
    background		: #ffffff;
    position		: absolute;
    z-index			: 9999;
    border-right	: 1px solid #d4d4d4;
    border-bottom	: 1px solid #d4d4d4;
    border-top 		: 1px solid #d4d4d4;
    border-radius	: 0px 3px 3px 0px;
    box-shadow		: 1px 1px 0px 0px #eaeaea;
}
#rightBtn{
	margin-top		: 65px;
    float			: right;
    margin-right	: -40px;
    width			: 35px;
    height			: 60px;
    border			: 1px solid #d4d4d4;
    border-radius	: 1px 5px 5px 0px;
    text-align		: center;
    line-height		: 48px;
    color			: #8c8c8c;
    border-left 	: 0;
    z-index			: 99999;
    background		: #ffffff;
    cursor			: pointer;
    box-shadow		: 1px 1px 0px 0px #eaeaea;
}
.check-list-table {
	border-bottom	: 2px solid #c3c3c3;
    margin-top		: 35px;
    padding-left	: 10px;
}
.check-list-div {
	height 			: 300px;
	border-bottom 	: 1px solid #d4d4d4;
	overflow		: auto;
}
#memoTextarea {
	width 			: 100%;
	height 			: 100px;
	padding 		: 5px;
}
.btn-add {
	margin-top 		: -25px;
}
.check_list_title {
	height 			: 24px !important;
}
.check_list_update_btn {
	color 			: #6670dc;
}
.check_list_update_btn:hover, .check_list_delete_btn:hover{
	font-weight 	: bold;
}
.check_list_detail:hover {
	border			: 1px solid #6694dc;
    border-radius	: 3px;
    box-shadow		: 1px 1px 0px 0px #ececec;
}
#memoSaveBtn {
	margin-top 		: -27px;
}
.check_list_update_input {
	width 			: 200px;
	height 			: 22px;
}
</style>

<script type="text/javascript">
$(function () {
	var url = location.href;
	
	// 체크 메모 정보 조회
	checkMemoInfo();
	
	$('.header_tabs li a').each(function (e) {
		if (url.indexOf($(this).attr('href')) != -1) {
			$(this).closest('li').addClass('active');			
		}
	});
	
	// left check list menu click event
	$('#rightBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		if ($(this).attr('show') == 'off') {
			$(this).attr('show', 'on');
			$(this).html('&lt;');
			
			$('#checkMemoDiv').animate({
				'left' 		: '0',
				'display' 	: 'block'
			});
		} else {
			
			$(this).attr('show', 'off');
			$(this).html('&gt;');
			
			$('#checkMemoDiv').animate({
				'left' 		: '-300px',
				'display' 	: 'none'
			});
		}
	});
	
	// 체크메모 저장
	$('#memoSaveBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		checkMemoMerge($(this).attr('idx'));
	});
	
	// 체크리스트 추가 button
	$('#checkListAddBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		$('#checkListTable tbody .check_list_empty').remove();
		
		var html  = '<tr class="check_list_add" checkListIdx="">';
			html += '	<td><button type="button" class="btn btn-danger btn-xs check_list_remove">x</button></td>';
			html += '	<td><input type="text" class="form-control check_list_title"/></td>';
			html += '</tr>';
		$('#checkListTable tbody').prepend(html);
		
		// 체크리스트 추가행 삭제
		$('.check_list_remove').unbind('click').click(function (e) {
			e.preventDefault();
			
			$(this).closest('tr').remove();
			
			if ($('#checkListTable tbody tr').length == 0) {
				$('#checkListTable tbody').append('<tr class="check_list_empty"><td colspan="2" class="text-center">체크 항목이 없습니다.</td></tr>');
			}
		});
	});
	
});

/**
 * 체크메모 정보 조회
 */
function checkMemoInfo () {
	
	$.ajax({
		url 		: '/rest/checkMemo/info',
		method 		: 'POST',
		dataType 	: 'JSON',
		success		: function (result) {
			if (result.status) {
				var info = result.info;
				
				if (info) {
					$('#memoSaveBtn').attr('idx', info.checkMemoIdx);
					$('#memoTextarea').val(info.memo);
					
					// 체크리스트
					$('#checkListTable tbody').empty();
					
					var checkList = info.checkList;
					var checkListLength = checkList.length;
					for (var i = 0; i < checkListLength; i++) {
						var isChecked = checkList[i].isChecked;
						
						var html  = '<tr class="check_list_info" checkListIdx="' + checkList[i].checkListIdx + '">';
							html += '	<td><input class="check_list_checkbox" type="checkbox" ' + (isChecked == '1' ? 'checked' : '') + '/></td>';
							html += '	<td>';
							html += '		<div class="' + (isChecked == '1' ? 'color-gray-remove' : '') + ' check_list_detail text-tooltip float-left" style="width:200px;">' + checkList[i].title + '</div>';
							html += '	</td>';
							html += '</tr>';
						$('#checkListTable tbody').prepend(html);
					}
					
					// 목록 없을 때
					if (checkListLength == 0) {
						$('#checkListTable tbody').append('<tr class="check_list_empty"><td colspan="2" class="text-center">체크 항목이 없습니다.</td></tr>');
					}
					
					// 체크리스트 row click
					$('#checkListTable tbody .check_list_detail').unbind('click').click(function (e) {
	
						var thisTag = $(this);
						var thisRow = thisTag.closest('tr');
						// 다른행 selected 클래스 삭제
						var thisIndex = thisRow.index();
						
						$('#checkListTable tbody .check_list_detail').each(function (i) {
							if (thisIndex != i) {
								$(this).closest('tr').removeClass('selected');
								$(this).closest('tr').find('td:eq(1) .check_list_merge_span').remove();
							}
						});
						
						thisTag.hide();
						thisTag.closest('td').append('<input value="' + thisTag.text() + '" type="text" class="form-control float-left check_list_update_input"/>');
						
						// 행 선택 취소
						if (thisRow.hasClass('selected')) {
							thisRow.removeClass('selected');
							thisRow.find('td:eq(1) .check_list_merge_span').remove();
						
						// 행 선택
						} else {
							thisRow.addClass('selected');
							
							// 수정 버튼 추가
							var html  = '<span class="check_list_merge_span float-right">';
								html += '	<span class="check_list_update_btn glyphicon glyphicon-edit" aria-hidden="true"></span>';
								html += '	<span class="check_list_delete_btn glyphicon glyphicon-trash" aria-hidden="true"></span>';
								html += '</span>';
							thisRow.find('td:eq(1)').append(html);
							
							// 선택 행 수정 form
							$('.check_list_update_btn').unbind('click').click(function (e) {
								e.preventDefault();
								
								var thisRow 	= $(this).closest('tr.check_list_info');
								var thisText 	= thisRow.find('td:eq(1) .check_list_detail');
								var input 	= thisRow.find('.check_list_update_input');
								
								$.ajax({
									url 		: '/rest/checkMemo/checkList/merge',
									method 		: 'POST',
									dataType 	: 'JSON',
									async		: false,
									data 		: {
										type 			: 'U',
										checkListIdx 	: thisRow.attr('checkListIdx'),
										title 			: input.val()
									},
									success 	: function (result) {
										if (result.status) {
											thisText.show();
											thisText.text(input.val());
											input.remove();
										}
									}
								});
								/*
								if (thisRow.find('input').hasClass('check_list_update_input')) {
									thisText.show();
									thisRow.find('.check_list_update_input').remove();					
									
								} else {
									thisText.hide();
									var html = '<input value="' + thisText.text() + '" type="text" class="form-control float-left check_list_update_input"/>';
									thisRow.find('td:eq(1)').append(html);
								} 
								*/
							}); 
							
							// 선택 행 삭제
							$('.check_list_delete_btn').unbind('click').click(function (e) {
								e.preventDefault();
								
								var thisRow = $(this).closest('tr.check_list_info');

								// confirm
								if (confirm('선택한 내용을 삭제하시겠습니까?')) {
									$.ajax({
										url 		: '/rest/checkMemo/checkList/merge',
										method 		: 'POST',
										dataType 	: 'JSON',
										data 		: {
											type			: 'D',
											checkListIdx 	: thisRow.attr('checkListIdx'),
										},
										success 	: function (result) {
											if (result.status) {
												if (result.result == 1) {
													thisRow.remove();
													alert('선택한 내용을 삭제하였습니다.');
													
												} else {
													alert('삭제를 실패하였습니다.');
												}
											} else {
												alert('서버 에러');
											}
										}
									});
								}
							});
						}
						
					});
					
					// 체크박스 check / uncheck 실시간 update
					$('#checkListTable tbody .check_list_checkbox').change(function (e) {
						e.preventDefault();
						
						var thisTag 	= $(this);
						var isChecked 	= thisTag.prop('checked');
						
						$.ajax({
							url 		: '/rest/checkMemo/checked',
							method		: 'POST',
							dataType 	: 'JSON',
							data 		: {
								checkListIdx 	: thisTag.closest('tr').attr('checkListIdx'),
								isChecked 		: isChecked ? '1' : '0'
							},
							success 	: function (result) {
								if (result.status) {
									
									if (isChecked) {
										thisTag.closest('tr').find('td:eq(1) .check_list_detail').addClass('color-gray-remove');
									} else {
										thisTag.closest('tr').find('td:eq(1) .check_list_detail').removeClass('color-gray-remove');
									}
									
								} else {
									alert('서버 에러');
								}
							}
						});
					});
				}
				
			} else {
				alert('서버 에러');
			}
		}
	});
}

/**
 * 체크메모 등록, 수정
 */
function checkMemoMerge (checkMemoIdx) {
	
	var type = '', typeText = '';
	
	if (checkMemoIdx) {
		type = 'U', typeText = '수정';
	} else {
		type = 'I', typeText = '등록';
	}
	var param = {
		type 			: type,
		checkMemoIdx 	: checkMemoIdx,
		memo			: $('#memoTextarea').val()
	};
	
	var addListTag = $('#checkListTable tbody .check_list_add');
	addListTag.each(function (i) {
		param['checkList[' + i + '].checkListIdx']	= $(this).attr('checkListIdx');
		param['checkList[' + i + '].title']			= $(this).find('.check_list_title').val();
	});
	console.log(param);
	//return false;
	
	$.ajax({
		url 		: '/rest/checkMemo/merge',
		method 		: 'POST',
		dataType 	: 'JSON',
		data 		: param,
		success 	: function (result) {
			if (result.status) {
				
				alert(typeText + '을 완료하였습니다.');
				// 체크메모 정보 재조회
				checkMemoInfo();
				
			} else {
				alert('서버 에러');
			}
		}
	});
}

</script>
<div>
	<a href="/logout" class="btn btn-default float-right">LOGOUT</a>
</div>
<ul class="nav nav-tabs header_tabs">
  <li role="presentation"><a href="/views/dashboard">DASHBOARD</a></li>
  <li role="presentation"><a href="/views/bankBook/list">가계부</a></li>
  <li role="presentation"><a href="/views/category/list">분류 코드</a></li>
  <li role="presentation"><a href="#">통계</a></li>
</ul>

<div id="checkMemoDiv">
	<!-- 우측 open / close 버튼 -->
	<div id="rightBtn" show="off">&gt;</div>
	
	<!-- header -->
	<div class="check-list-table">
		<h4>체크 리스트</h4>
		<button type="button" class="btn btn-default btn-xs float-right btn-add" id="checkListAddBtn">+</button> 
	</div>
	
	<!-- check list -->
	<div class="check-list-div">
		<table class="table" id="checkListTable">
			<colgroup>
				<col width="10%"/>
				<col width="auto"/>
			</colgroup>
			<tbody>
				<tr class="check_list_empty">
					<td colspan="2" class="text-center">체크 항목이 없습니다.</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div>
		<h5>Memo</h5>
		<button type="button" class="btn btn-primary btn-xs float-right" id="memoSaveBtn" idx="">메모 저장</button>
		<textarea id="memoTextarea" class="form-control"></textarea>
	</div>
</div>