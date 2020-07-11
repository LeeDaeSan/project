<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#periodTable {
	margin 	: 0 auto;
	width 	: 150px;
}
#periodTable #yearSelect {
	width : 80%;
	float : left;
}
#bankBookStatisticsTable {
	width 		: 2300px;
	overflow 	: auto;
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
	
	// 통계 목록 조회
	statisticsList();
	
	// 연도 변경
	$('#yearSelect').change(function () {
		statisticsList();
	});
});

function statisticsList () {
	
	$.ajax({
		url 		: '/rest/statistics/select',
		method		: 'POST',
		dataType	: 'JSON',
		data		: {
			statisticsRealDate : $('#yearSelect').val()
		}
	}).done(function (result) {
		if (result.status) {
			
			// 초기화
			$('#bankBookStatisticsTable tbody tr').each(function () {
				$(this).find('td').each(function () {
					if ($(this).index() > 0) {
						$(this).empty();
					}
				});
			});
			$('#bankBookStatisticsTable tfoot tr').each(function () {
				$(this).find('td').each(function () {
					if ($(this).index() > 0) {
						$(this).empty();
					}
				});
			});
			
			// 데이터 바인딩
			var list 		= result.list;
			var listLength 	= list.length;
			var headLength	= $('#bankBookStatisticsTable thead tr th').length;
			for (var i = 0; i < listLength; i++) {
				var thisData 	= list[i];
				var thisMonth 	= Number(thisData.statisticsRealDate.substring(4));
				var thisTr 		= $('#bankBookStatisticsTable tbody tr:eq(' + (thisMonth - 1) + ')');
				var tdIndex 	= 1;
				
				var incomeAmount 	= thisData.incomeAmount;
				var spendingAmount 	= thisData.spendingAmount;
				var remainingAmount = thisData.remainingAmount;
				
				// 수입 총액의 총액
				var incomeTotalTag = $('.total_row_tr td:eq(' + tdIndex + ')');
				var incomeAmountTotal = common.number.onlyNumber(incomeTotalTag.text());
				incomeTotalTag.text(
					common.number.addComma(
						Number(incomeAmountTotal) + Number(incomeAmount)));
				// 수입 총액
				thisTr.find('td:eq(' + tdIndex++ + ')').append(
						'<span class="color-blue">' + common.number.addComma(thisData.incomeAmount) + '</span>');

				// 지출 총액의 총액
				var spendingTotalTag = $('.total_row_tr td:eq(' + tdIndex + ')');
				var spendingAmountTotal = common.number.onlyNumber(spendingTotalTag.text());
				spendingTotalTag.text(
					common.number.addComma(
						Number(spendingAmountTotal) + Number(spendingAmount)));
				// 지출 총액
				thisTr.find('td:eq(' + tdIndex++ + ')').append(
						'<span class="color-red">' + common.number.addComma(thisData.spendingAmount) + '</span>');
				
				// 남은 금액의 총액
				var remainingTotalTag = $('.total_row_tr td:eq(' + tdIndex + ')');
				var remainingAmountTotal = common.number.onlyNumber(remainingTotalTag.text());
				remainingTotalTag.text(
					common.number.addComma(
						Number(remainingAmountTotal) + Number(remainingAmount)));
				// 남은 금액
				thisTr.find('td:eq(' + tdIndex++ + ')').append(
						'<span class="color-green">' + common.number.addComma(thisData.remainingAmount) + '</span>');
				
				var detailList = thisData.bankBookStatisticsDetailList;
				var detailLength = detailList.length;
				for (var j = 0; j < detailLength; j++) {
					var thisDetailData = detailList[j];
					
					// header title add
					
					if (i == 0 && headLength <= 4) {
						$('#bankBookStatisticsTable thead tr').append('<th class="text-center" categoryIdx="' + thisDetailData.categoryIdx + '">' + thisDetailData.category1.categoryName + '</th>');
					}
					
					$('#bankBookStatisticsTable thead tr th').each(function () {
						if ($(this).attr('categoryIdx') == thisDetailData.categoryIdx) {
							var thisIndex = $(this).index();
							
							thisTr.find('td:eq(' + thisIndex + ')').append(
								common.number.addComma(thisDetailData.amount ? thisDetailData.amount : 0)
								+ '<b class="color-blue">[' + common.number.percentage(thisDetailData.amount, spendingAmount, 1) + ']</b>');
							
							var totalTag = $('.total_row_tr td:eq(' + thisIndex + ')');
							var amountTotal = common.number.onlyNumber(totalTag.text());
							totalTag.text(
								common.number.addComma(
									Number(amountTotal) + Number(thisDetailData.amount)));
						}
					});
					
				}
				
			}
			
		} else {
			alert('서버 에러');
		}
		
	}).fail(function (result) {
		
	});
}
</script>

<div class="container-fluid">
	<h4 class="mb-2 text-gray-800">연말 통계</h4>
	
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
				</tr>
			</table>
		</div>
    </div>
    
	<!-- list START -->
    <div class="card shadow mb-4">
	    <div class="card-header py-3">
	      	<h6 class="m-0 font-weight-bold text-primary">통계 목록</h6>
	    </div>
	    
	    <div class="card-body">
          	<div class="table-responsive">
               	<table class="table table-bordered" id="bankBookStatisticsTable">
               		<colgroup>
						<col width="3%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
					</colgroup>
               		<thead>
                   		<tr>
							<th class="text-center">월</th>
							<th class="text-center">수입 총액</th>
							<th class="text-center">지출 총액</th>
							<th class="text-center">남은 금액</th>
                   		</tr>
                 	</thead>
               		<tbody>
               			<tr>
               				<td class="text-right">1월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">2월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">3월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">4월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">5월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">6월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">7월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">8월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">9월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">10월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">11월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               			<tr>
               				<td class="text-right">12월</td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               			</tr>
               		</tbody>
               		
               		<tfoot>
               			<tr>
               				<td colspan="19"></td>
               			</tr>
               			<tr class="total_row_tr">
                   			<td class="text-right"><b>합계</b></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
               				<td class="text-right"></td>
                   		</tr>
               		</tfoot>
              	</table>	
           	</div>
           	
       	</div>
       	
    </div>
</div>