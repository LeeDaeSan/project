<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/api/amChart/core.js"></script>
<script type="text/javascript" src="/api/amChart/charts.js"></script>
<script type="text/javascript" src="/api/amChart/animated.js"></script>

<style>
#chartdiv {
  width: 100%;
  height: 500px;
}
</style>

<script>
// 현재 달
var nowMonth = (new Date().getMonth() + 1);

am4core.ready(function() {
	
$('#monthTitle').text(nowMonth + '월  가계 통계');

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end


/**
 * Define data for each year
 */
 
//Create chart instance
 var chart = am4core.create("chartdiv", am4charts.PieChart);
 var chartData = {};
 $.ajax({
	url 		: '/rest/dashboard/list',
	method 		: 'POST',
	dataType 	: 'JSON',
	async		: false,
	data 		: {},
	success 	: function (result) {
		if (result.status) {
			
			// 소득 총액
			var inTotalAmount = 0;
			// 지출 총액
			var outTotalAmount = 0;
			
			var list = result.list;
			var listLength = list.length;
			var chartList = [];
			for (var i = 0; i < listLength; i++) {
				var thisData = list[i];
				
				if (thisData.amountType != 'IN') {
					chartList.push({
						'sector' 	: thisData.categoryName,
						'size'		: thisData.totalAmount,
					});
					outTotalAmount += thisData.totalAmount;
				} else {
					inTotalAmount += thisData.totalAmount;
				}
			}

			// 소득 총액 bind
			$('#inTotalAmount').text(common.number.addComma(inTotalAmount));
			// 지출 총액 bind
			$('#outTotalAmount').text(common.number.addComma(outTotalAmount));
			// 차액 bind
			var diffAmount = inTotalAmount - outTotalAmount;
			$('#diffAmount').text(common.number.addComma(diffAmount));
			// 통장 잔액 bind
			var remainAmount = result.remainAmount;
			$('#remainAmount').text(common.number.addComma(remainAmount));
			// 전월 잔액 bind
			var befAmount = Math.abs(diffAmount) + remainAmount;
			$('#befAmount').text(common.number.addComma(befAmount));
			
			$('#befAmount').text();
			if (diffAmount < 0) {
				$('#diffAmount').addClass('color-red');	
			} else if (diffAmount > 0) {
				$('#diffAmount').addClass('color-blue');
			}
		
			chartData[nowMonth + '월'] = chartList;
			chart.data = chartList;
		} else {
			alert('서버 에러');
		}
	}
});

// Add label
chart.innerRadius = 100;
var label = chart.seriesContainer.createChild(am4core.Label);
label.text = nowMonth + '월';
label.horizontalCenter = "middle";
label.verticalCenter = "middle";
label.fontSize = 50;

// Add and configure Series
var pieSeries = chart.series.push(new am4charts.PieSeries());
pieSeries.dataFields.value = "size";
pieSeries.dataFields.category = "sector";
/* 
// Animate chart data
var currentYear = 1995;
function getCurrentData() {
  label.text = currentYear;
  var data = chartData[currentYear];
  currentYear++;
  if (currentYear > 2014)
    currentYear = 1995;
  return data;
}

function loop() {
  //chart.allLabels[0].text = currentYear;
  var data = getCurrentData();
  for(var i = 0; i < data.length; i++) {
    chart.data[i].size = data[i].size;
  }
  chart.invalidateRawData();
  chart.setTimeout( loop, 4000 );
}

loop(); */

}); // end am4core.ready()
</script>

<div class="col-md-12">
	<div class="col-md-5">
		<table class="table">
			<colgroup>
				<col width="20%"/>
				<col width="40%"/>
				<col width="auto"/>
			</colgroup>
			<thead>
				<tr>
					<th class="text-left" colspan="3"><h4 id="monthTitle"></h4></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th class="text-left">총 수익</th>
					<td></td>
					<td class="text-right color-blue" id="inTotalAmount"></td>
				</tr>
				<tr>
					<th class="text-left">총 지출</th>
					<td></td>
					<td class="text-right color-red" id="outTotalAmount"></td>
				</tr>
				<tr>
					<th class="text-left">차액</th>
					<td class="text-right">총 수익 - 총 지출</td>
					<td class="text-right" id="diffAmount"></td>
				</tr>
				<tr>
					<th class="text-left">통장 잔액</th>
					<td></td>
					<td class="text-right color-green" id="remainAmount"></td>
				</tr>
				<tr>
					<th class="text-left">전월 잔액</th>
					<td class="text-right">차액 + 통장 잔액</td>
					<td class="text-right color-green" id="befAmount"></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="col-md-7">
		<div id="chartdiv"></div>
	</div>
</div>
