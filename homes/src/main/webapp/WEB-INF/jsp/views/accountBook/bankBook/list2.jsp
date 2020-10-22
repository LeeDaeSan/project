<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.button-area {
	margin-bottom 	: 7px;
	height 			: 31px;
}
#allSaveAccountBtn, #selectBtn {
	margin-right 	: 5px;
}
.count-content-div {
	margin-top 		: 10px;
	padding-left 	: 5px;
}
.table b {
	color : #0006d0;
}
#periodTable {
	margin 	: 0 auto;
	width 	: 250px;
}
#periodTable #yearSelect {
	width : 80%;
	float : left;
}
#periodTable #monthSelect {
	width : 50%;
	float : left;
}
.row_del_btn {
	padding : 0px 8px 0px 8px;
}
</style>
<script type="text/javascript">
var dateNow 	= new Date();
var nowYear 	= dateNow.getFullYear();
var nowMonth 	= (dateNow.getMonth() + 1);
	nowMonth	= nowMonth < 10 ? '0' + nowMonth : nowMonth;

$(function () {

	// 현재 날짜 지정
	$('#yearSelect').val(nowYear);
	$('#monthSelect').val(nowMonth);
	
	// 목록 조회
	accountBookList();

	// 검색
	$('#selectBtn').unbind('click').click(function (e) {
		e.preventDefault();
		accountBookList();
	});
	
	// 년 변경
	$('#yearSelect').change(function () {
		accountBookList();	
	});
	
	// 월 변경
	$('#monthSelect').change(function () {
		accountBookList();
	});
	
	// row 추가하기
	$('#rowAddBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		var html  = '<tr class="add_tr">';
			html += '	<td></td>';
			html += '	<td><input type="text" class="form-control account_date_input datepicker text-center"/></td>';
		
			for (var i = 1; i <= 5; i++) {
				html += '	<td>';
				html += '		<select class="form-control category_' + i + '" level="' + i + '">';
				if (i == 1) {
					html += 		categoryFunction(i);
				} else {
					html += '		<option value="">선택</option>';
				}
				html += '	</td>';
			}
			
			html += '	<td><input type="text" class="form-control content_input"/></td>';
			html += '	<td><input type="text" class="form-control amount_input text-right"/></td>';
			html += '	<td><button class="btn btn-danger btn-sm add_row_del">x</button></td>';
			html += '</tr>';
			
		$('#accountBookTable tbody').prepend(html);

		// datepicker 재 정의
		$('.datepicker').datepicker('destroy');
		$('.datepicker').datepicker({
			format 		: 'yyyy-mm-dd',		// 포맷 형식
			autoclose 	: true,				// 날짜 선택시 자동 close
		});
		
		// row 삭제
		$('.add_row_del').unbind('click').click(function (e) {
			e.preventDefault();
			
			$(this).closest('.add_tr').remove();
		});
		
		// 카테고리1 ~ 5 셀렉트박스 change event
		for (var i = 1; i <= 5; i++) {
			$('.category_' + i).off('change').change(function (e) {
				e.preventDefault();
				
				var thisIdx 	= $(this).attr('level');
				var nextIdx		= (Number(thisIdx) + 1);
				var parentIdx 	= $(this).val();
				
				// 다음 레벨 카테고리 select box 초기화
				$(this).closest('tr').find('.category_' + nextIdx).empty();
				// 다음 레벨 카테고리 select box 추가
				$(this).closest('tr').find('.category_' + nextIdx).append(categoryFunction(nextIdx, parentIdx));
			});
		}
		
		// 금액 keyup event
		$('.amount_input').off('keyup').keyup(function (e) {
			e.preventDefault();
			
			var thisData = common.number.onlyNumber($(this).val());
				thisData = common.number.addComma(thisData);

			$(this).val(thisData);
		});
	});
	
	// 일괄 저장 (등록, 수정)
	$('#allSaveAccountBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		var addData = $('#accountBookTable tbody tr.add_tr');
		var addDataLength = addData.length;
		
		// 추가 데이터가 없을 때
		if (addDataLength == 0) {
			alert('추가한 정보가 없습니다.');
			return false;
			
		} else {
			
			var addParams = {
				type : 'I'
			};
			
			for (var i = 0; i < addDataLength; i++) {
				var thisTr = $(addData[i]);
				
				var accountDate 	= thisTr.find('.account_date_input').val();
				var category1Idx 	= thisTr.find('.category_1').val();
				var category2Idx 	= thisTr.find('.category_2').val();
				var category3Idx 	= thisTr.find('.category_3').val();
				var category4Idx 	= thisTr.find('.category_4').val();
				var category5Idx 	= thisTr.find('.category_5').val();
				var amount 			= thisTr.find('.amount_input').val();
				var content			= thisTr.find('.content_input').val();
				
				// 날짜 validation
				if (!accountDate) {
					alert('날짜를 입력해 주세요.');
					return false;
				}
				
				// 카테고리1 validation
				if (!category1Idx) {
					alert('분류1 항목을 선택해 주세요.');
					return false;
				}
				
				// 카테고리2 validation
				if (!category2Idx) {
					alert('분류2 항목을 선택해 주세요.');
					return false;
				}
				
				// 카테고리3 validation
				if (!category3Idx) {
					alert('분류3 항목을 선택해 주세요.');
					return false;
				}
				
				// 금액 validation
				if (!amount) {
					alert('금액 항목을 입력해 주세요.');
					return false;
				}
				
				addParams['accountBookList[' + i + '].accountDateStr'] 	= accountDate;
				addParams['accountBookList[' + i + '].category1Idx'] 	= category1Idx;
				addParams['accountBookList[' + i + '].category2Idx']	= category2Idx;
				addParams['accountBookList[' + i + '].category3Idx'] 	= category3Idx;
				addParams['accountBookList[' + i + '].category4Idx'] 	= category4Idx;
				addParams['accountBookList[' + i + '].category5Idx'] 	= category5Idx;
				addParams['accountBookList[' + i + '].amount'] 			= common.number.onlyNumber(amount);
				addParams['accountBookList[' + i + '].content'] 		= content;
				
			}

			// confirm
			if (confirm('일괄 저장하시겠습니까?')) {
				$.ajax({
					url 		: '/rest/accountBook/merge',
					method 		: 'POST',
					dataType	: 'JSON',
					data		: addParams,
					
				}).done(function (result) {
					if (result.status) {
						// 목록 조회
						accountBookList();
						
						alert('저장 완료하였습니다.');
					}
				});
			}
		}
	});
});

/**
 * 가계부 목록 조회
 */
function accountBookList () {

	$.ajax({
		url			: '/rest/accountBook/list',
		method 		: 'POST',
		dataType 	: 'JSON',
		data		: {
			startDateStr : $('#yearSelect').val() + $('#monthSelect').val()
		}
	
	}).done(function (result) {
		
		if (result.status) {
			
			var html		= '';
			var list 		= result.list;
			var listLength 	= list.length;
			
			var inTotalAmount 	= 0;
			var outTotalAmount 	= 0;
			
			for (var i = 0; i < listLength; i++) {
				var thisData = list[i];
				
				var amount 			= thisData.amount;
				var category1Idx 	= thisData.accountCategory1.categoryIdx;
				
				// 1 = 지출
				if (category1Idx == 1) {
					outTotalAmount += amount;
				// 2 = 수입 
				} else if (category1Idx == 2) {
					inTotalAmount += amount;
				}
				
				html += '<tr accountBookIdx="' + thisData.accountBookIdx + '">';
				html += '	<td class="text-right">' + (listLength - i) + '</td>';
				html += '	<td class="text-center">' + common.date.toString(new Date(thisData.accountDate), '-') + '</td>';
				html += '	<td class="text-center">' + isEmpty(thisData.accountCategory1, 'categoryName') + '</td>';
				html += '	<td>' + isEmpty(thisData.accountCategory2, 'categoryName') + '</td>';
				html += '	<td>' + isEmpty(thisData.accountCategory3, 'categoryName') + '</td>';
				html += '	<td>' + isEmpty(thisData.accountCategory4, 'categoryName') + '</td>';
				html += '	<td>' + isEmpty(thisData.accountCategory5, 'categoryName') + '</td>';
				html += '	<td>' + thisData.content + '</td>';
				html += '	<td class="text-right ' + (category1Idx == 1 ? 'color-red' : 'color-blue') + '">' + common.number.addComma(amount) + '</td>';
				html += '	<td class="text-center"><button class="btn btn-danger btn-sm row_del_btn">x</button></td>';
				html += '</tr>';	
			}
			
			// 수입 총액
			$('#inTotalAmount').text(common.number.addComma(inTotalAmount));
			// 지출 총액
			$('#outTotalAmount').text(common.number.addComma(outTotalAmount));
			// 창액
			$('#otherTotalAmount').text(common.number.addComma(inTotalAmount - outTotalAmount));
			
			// 데이터가 없을 때
			if (listLength == 0) {
				html += '<tr><td class="text-center" colspan="10">데이터가 없습니다.</td></tr>';
			}
			
			$('#accountBookTable tbody').empty().append(html);
			
			// row 삭제
			$('.row_del_btn').unbind('click').click(function (e) {
				e.preventDefault();
				
				var thisIdx = $(this).closest('tr').attr('accountBookIdx');
				
				if (confirm('삭제하시겠습니까?')) {
					$.ajax({
						url 		: '/rest/accountBook/merge',
						dataType	: 'JSON',
						method		: 'POST',
						data		: {
							type			: 'D',
							accountBookIdx 	: thisIdx
						}
					}).done(function (result) {
						if (result.status) {
							// 목록 조회
							accountBookList();
							
							alert('삭제하였습니다.');
						}
					});
				}
				
			});
			
		} else {
			alert('서버 에러');
		}
		
	}).fail(function (result) {
		alert('서버 에러');
	});
}

function isEmpty (obj, key) {
	try {
		obj = obj[key];
	} catch (e) {
		obj = '';
	}
	
	return obj;
}
/**
 * 카테고리 목록 조회
 */
function categoryFunction (level, parentIdx) {
	
	var html = '';
	
	$.ajax({
		url 		: '/rest/accountCategory/listOfAccountBank',
		method		: 'POST',
		dataType	: 'JSON',
		async		: false,
		data		: {
			parentIdx : parentIdx
		},
	}).done(function (result) {
		
		if (result.status) {
			
			var dataList = result.list;
			var listLength = dataList.length;
			
			html += '	<option value="">선택</option>';
			for (var i = 0; i < listLength; i++) {
				var thisData = dataList[i];
				html += '<option value="' + thisData.categoryIdx + '">' + thisData.categoryName + '</option>';
			} 
			
		} else {
			alert('카테고리 목록 조회 실패');
		}
	});
	
	return html;
}
</script>

<div class="container-fluid">
	<h4 class="mb-2 text-gray-800">가계 관리</h4>
	
	<div class="card shadow mb-4">
		<div class="card-body">
			<table id="periodTable">
				<colgroup>
					<col width="50%"/>
					<col width="50%"/>
				</colgroup>
				<tr>
					<th>
						<select id="yearSelect" class="form-control form-control-sm">
							<option value="2019">2019</option>
							<option value="2020">2020</option>
						</select>
						&nbsp;<b>년</b>
					</th>
					<th>
						<select id="monthSelect" class="form-control form-control-sm">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>
						&nbsp;<b>월</b>
					</th>
				</tr>
			</table>
		</div>
    </div>
    
	<div class="float-left count-content-div">
		<span>
			입금 총액 : <span id="inTotalAmount" class="color-blue">0</span>
		</span>
		<span><b>|</b></span>
		<span>
			출금 총액 : <span id="outTotalAmount" class="color-red">0</span>
		</span>
		<span><b>|</b></span>
		<span>
			차액 : <span id="otherTotalAmount" class="color-green">0</span>
		</span>
	</div>
	
	<div class="button-area">
		<button class="btn btn-primary btn-sm float-right" id="rowAddBtn">추가</button>
		<button class="btn btn-success btn-sm float-right" id="allSaveAccountBtn">저장</button>
		<button class="btn btn-primary btn-sm float-right" id="selectBtn">검색</button>
	</div>
	
	<!-- list START -->
    <div class="card shadow mb-4 col-md-12">
	    <div class="card-header py-3">
	      	<h6 class="m-0 font-weight-bold text-primary">통장 목록</h6>
	    </div>
    	<div class="card-body">
          	<div class="table-responsive">
               	<table class="table table-bordered" id="accountBookTable">
               		<colgroup>
               			<col width="5%"/>
               			<col width="10%"/>
               			<col width="7%"/>
               			<col width="10%"/>
               			<col width="10%"/>
               			<col width="10%"/>
               			<col width="10%"/>
               			<col width="auto"/>
               			<col width="10%"/>
               			<col width="5%"/>
               		</colgroup>
               		<thead>
               			<tr>
	               			<th class="text-center">번호</th>
	               			<th class="text-center">날짜</th>
	               			<th class="text-center">분류1</th>
	               			<th class="text-center">분류2</th>
	               			<th class="text-center">분류3</th>
	               			<th class="text-center">분류4</th>
	               			<th class="text-center">분류5</th>
	               			<th class="text-center">상세</th>
	               			<th class="text-center">금액</th>
	               			<th class="text-center">삭제</th>
               			</tr>
               		</thead>
               		<tbody class="text-tooltip">
               		</tbody>
               	</table>
           	</div>
       	</div>
   	</div>
</div>