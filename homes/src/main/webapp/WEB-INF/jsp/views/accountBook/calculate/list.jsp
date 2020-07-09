<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.count-line {
	font-size : 13px;
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
.hide-div {
	width		: 100%;
    height		: 100%;
    background	: #000;
    position	: absolute;
    opacity		: 0.3;
    left		: 0;
}
#calculateBtn {
	margin-bottom : 5px;
}
.calculate-div {
	width 	: 100%;
	height 	: 37px;
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
	calculateList();
	
	// 연도 셀렉트박스 변경
	$('#yearSelect').change(function () {
		// 목록 조회
		calculateList();
	});
	
	// 월 셀렉트박스 변경
	$('#monthSelect').change(function () {
		// 목록 조회
		calculateList();
	});
	
	$('#calculatePopupTitle').text($('#yearSelect').val() + '년' + $('#monthSelect').val() + '월');
});

/**
 * 정산 목록 조회 Function
 */
function calculateList () {
	var searchYear 		= $('#yearSelect').val();
	var searchMonth 	= $('#monthSelect').val();
	var amountDateStr 	= searchYear + '' + searchMonth;
	
	if (nowYear == searchYear && nowMonth == searchMonth) {
		$('#hideDiv').removeClass('hide-div');
	} else {
		$('#hideDiv').addClass('hide-div');
	}
	
	$('#calculateTitle').text(searchYear + '년 ' + searchMonth + '월 ');
	
	$.ajax({
		url 		: '/rest/bankBookDetail/calculate/list',
		method		: 'POST',
		dataType	: 'JSON',
		async		: false,
		data		: {
			amountDateStr : amountDateStr,
		},
		
	}).done(function (result) {
		
		if (result.status) {
			
			$('#bankBookDetailTable tbody').empty();
			
			var inCount 		= 0;
			var outCount 		= 0;
			var inTotalAmount 	= result.inTotalAmount;
			var outTotalAmount 	= result.outTotalAmount;
			
			var list 		= result.list;
			var listLength 	= list.length;
			
			// 데이터가 없을때
			if (listLength == 0) {
				$('#bankBookDetailTable tbody.in_tbody').append('<tr><td class="text-center" colspan="8">데이터가 없습니다.</td></tr>');
			}
			
			for (var i = 0; i < listLength; i++) {
				var thisData = list[i];
				var thisClass = 'category_' + thisData.category1Idx;
				
				var html = '<tr>';
				
				// 수입
				if (thisData.amountType == 'IN') {
					// 유형1
					if (inCount == 0) {
						html += '<td class="text-center" id="inCountTd">수입</td>';
					}
					
					// 카테고리
					if (!$('#bankBookDetailTable tbody.in_tbody tr td').hasClass(thisClass)) {
						html += '<td rowspan="' + thisData.totalCount + '">' + thisData.category1.categoryName + '</td>';
						html += '<td class="text-right category_' + thisData.category1Idx + '" rowspan="' + thisData.totalCount + '">';
						html += 	(thisData.totalAmount ? common.number.addComma(thisData.totalAmount) : 0);
						html += '</td>';
						html += '<td class="text-center" rowspan="' + thisData.totalCount + '">-</td>';
					}
					
					inCount++;
					
				// 지출
				} else {
					// 유형1
					if (outCount == 0) {
						html += '<td class="text-center" id="outCountTd">지출</td>';
					}
					
					// 카테고리
					if (!$('#bankBookDetailTable tbody.out_tbody tr td').hasClass(thisClass)) {
						html += '<td rowspan="' + thisData.totalCount + '">' + thisData.category1.categoryName + '</td>';
						html += '<td class="text-right category_' + thisData.category1Idx + '" rowspan="' + thisData.totalCount + '">';
						html += 	(thisData.totalAmount ? common.number.addComma(thisData.totalAmount) : 0);
						html += '</td>';
						html += '<td class="text-right" rowspan="' + thisData.totalCount + '"><b>' + common.number.percentage(thisData.totalAmount, outTotalAmount, 1) + '</b></td>';
					}
					
					outCount++;
				}
	
				// 유형2
				html += '	<td class="text-tooltip">' + (thisData.category2 ? thisData.category2.categoryName : '-') + '</td>';
				// 금액
				html += '	<td class="text-right">' + (thisData.amount ? common.number.addComma(thisData.amount) : 0) + '</td>';
				html += '	<td class="text-center">' + common.date.toString(new Date(thisData.amountDate), '-') + '</td>';
				html += '	<td class="text-tooltip">' + thisData.content + '</td>';
				html += '</tr>';
				
				if (thisData.amountType == 'IN') {
					$('#bankBookDetailTable tbody.in_tbody').append(html);
				} else {
					$('#bankBookDetailTable tbody.out_tbody').append(html);
				}
			}
			
			// 유형 column rowspan append
			$('#inCountTd').attr('rowspan'	, inCount);
			$('#outCountTd').attr('rowspan'	, outCount);
			
			// 수입 총액
			$('#inTotalAmount').text(common.number.addComma(inTotalAmount));
			// 지출 총액
			$('#outTotalAmount').text(common.number.addComma(outTotalAmount));
			// 남은 금액
			$('#remainTotalAmount').text(common.number.addComma(inTotalAmount - outTotalAmount));
			
			$('.table tbody tr td').hover(function () {
				var tdCount = $(this).closest('tr').find('td').length;

				$(this).closest('tr').find('td').each(function (i) {
					if (tdCount == 8 && i > 3) {
						$(this).css('background', '#e0e0e0');
					} else if (tdCount == 7 && i > 2) {
						$(this).css('background', '#e0e0e0');
					} else if (tdCount < 7) {
						$(this).css('background', '#e0e0e0');
					} 
				});
			}, function () {
				$(this).closest('tr').find('td').css('background', '#ffffff');
			});
			
		} else {
			alert('정보 조회 실패');
		}
		
	}).fail(function (result) {
		
	});
}
</script>
<div class="container-fluid">
	<h4 class="mb-2 text-gray-800">월말 정산</h4>
	
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
	
	<div class="calculate-div">
		<button type="button" class="btn btn-primary btn-sm float-right" id="calculateBtn" data-toggle="modal" data-target="#calculateModal">정산하기</button>
	</div>
	
	<!-- list START -->
    <div class="card shadow mb-4">
		<div class="hide-div" id="hideDiv"></div>
    			
	    <div class="card-header py-3">
	      	<h6 class="m-0 font-weight-bold text-primary"><span id="calculateTitle"></span> 정산 목록</h6>
	    </div>
	    
	    <div class="card-body">
	    	<div class="count-line">
				<span>수입 총액 : <span id="inTotalAmount" class="color-blue">0</span></span>
				&nbsp;&nbsp;
				<span>지출 총액 : <span id="outTotalAmount" class="color-red">0</span></span>
				&nbsp;&nbsp;
				<span>남은 금액 : <span id="remainTotalAmount" class="color-green">0</span></span>
			</div>
          	<div class="table-responsive">
               	<table class="table" id="bankBookDetailTable">
               		<colgroup>
               			<col width="10%"/>
               			<col width="10%"/>
               			<col width="15%"/>
               			<col width="10%"/>
               			<col width="10%"/>
               			<col width="12%"/>
               			<col width="12%"/>
               			<col width="auto"/>
					</colgroup>
               		<thead>
                   		<tr>
							<th class="text-center">유형</th>
							<th class="text-center">분류1</th>
							<th class="text-center">분류1 총액</th>
							<th class="text-center">비율(%)</th>
							<th class="text-center">분류2</th>
							<th class="text-center">금액</th>
							<th class="text-center">날짜</th>
							<th class="text-center">비고</th>
                   		</tr>
                 	</thead>
               		<tbody class="in_tbody"></tbody>
               		<tbody class="out_tbody"></tbody>
               		<tfoot>
               			<tr><td colspan="8"></td></tr>
               		</tfoot>
              	</table>	
           	</div>
       	</div>
       	
    </div>
</div>
	
<div class="modal fade" id="calculateModal" tabindex="-1" role="dialog" aria-labelledby="myCalculateModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myCalculateModalLabel"><span id="calculatePopupTitle"></span> 정산 내역</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
			</div>
		</div>
	</div>
</div>
