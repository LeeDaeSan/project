<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/lib/amChart/core.js"></script>
<script type="text/javascript" src="/lib/amChart/charts.js"></script>
<script type="text/javascript" src="/lib/amChart/animated.js"></script>

<style>
#chartdivBar, #chartdiv {
  width			: 100%;
  height		: 370px;
}
#chartTable td, #chartTable th {
	padding 	: 7px 6px 7px 6px !important;
}
.daily-check-memo-table {
	height 		: 200px;
	overflow 	: auto;
}
</style>
<script type="text/javascript">
//현재 달
var nowMonth = (new Date().getMonth() + 1);
var duration = 1000;

am4core.ready(function() {
	
	// 체크 메모 목록 조회
	dailyCheckMemo();
	
	// 통계 타이틀 append
	$('#monthTitle').text(nowMonth + '월  가계 통계');
	
	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end
	
	//Create chart instance
	var chartData = {};
	$.ajax({
		url 		: '/rest/dashboard/list',
		method 		: 'POST',
		dataType 	: 'JSON',
		async		: false,
		data 		: {},
		success 	: function (result) {
			if (result.status) {
				
				var list 		= result.list;
				var listLength 	= list.length;
				var chartList 	= [];
				var html 		= '';
				for (var i = 0; i < listLength; i++) {
					var thisData = list[i];
				
					// 테이블에 필요한 데이터
					html += '<tr>';
					html += '	<td>' + thisData.categoryName + '</td>';
					html += '	<td class="text-right">' + common.number.addComma(thisData.totalAmount) + '</div>';
					html += '</tr>';
					
					// 차트에 필요한 데이터
					chartList.push({
						'sector' 	: thisData.categoryName,
						'size'		: thisData.totalAmount,
					});
				}
				
				// 데이터가 없을 때
				if (listLength == 0) {
					html = '<tr><th colspan="2">데이터가 없습니다.</td></tr>';
				}
				
				$('#chartTable tbody').empty().append(html);
				
				var totalData = result.totalData;
				// 소득 총액 bind
				common.number.mountCount(totalData.inTotalAmount, $('#inTotalAmount'), duration);
				// 지출 총액 bind
				common.number.mountCount(totalData.outTotalAmount, $('#outTotalAmount'), duration);
				// 차액 bind
				common.number.mountCount(totalData.otherTotalAmount, $('#diffAmount'), duration);
				// 총 자산 bind
				var totalAssets = result.totalAssets;
				common.number.mountCount(totalAssets, $('#totalAssets'), duration);
				
				$('#befAmount').text();
				if (diffAmount < 0) {
					$('#diffAmount').addClass('color-red');	
				} else if (diffAmount > 0) {
					$('#diffAmount').addClass('color-blue');
				}
			
			// ============= Pie Chart START ============= //
				var chart = am4core.create('chartdiv', am4charts.PieChart);
				chartData[nowMonth + '월'] = chartList;
				chart.data = chartList;
				// Add label
				chart.innerRadius = 100;
				
				var label 					= chart.seriesContainer.createChild(am4core.Label);
					label.text 				= nowMonth + '월';
					label.horizontalCenter 	= 'middle';
					label.verticalCenter 	= 'middle';
					label.fontSize 			= 50;

				// Add and configure Series
				var pieSeries 						= chart.series.push(new am4charts.PieSeries());
					pieSeries.dataFields.value 		= 'size';
					pieSeries.dataFields.category 	= 'sector';
			// ============= Pie Chart END ============= //		
					
			} else {
				alert('서버 에러');
			}
		}
	});

});

function dailyCheckMemo () {
	$.ajax({
		url			: '/rest/dashboard/checkMemo/daily',
		method		: 'POST',
		dataType	: 'JSON',
		async		: false,
		data		: {}
	
	}).done(function (result) {
		
		if (result.status) {
			
			// 목록 초기화
			$('#todayCheckMemoTable tbody, #befdayCheckMemoTable tbody').empty();
			
			var todayList 		= result.todayList;
			var todayListLength = todayList.length;
			for (var i = 0; i < todayListLength; i++) {
				var thisData = todayList[i];
				
				var html  = '<tr class="text-tooltip">';
					html += '	<td>' + thisData.transferDate + '일</td>';
					html += '</tr>';
			}
			if (todayListLength == 0) {
				$('#todayCheckMemoTable tbody').append('<tr><td class="text-center" colspan="6">내용이 없습니다.</td></tr>');
			}
			
			var befdayList 			= result.befdayList;
			var befdayListLength 	= befdayList.length;
			for (var i = 0; i < befdayListLength; i++) {
				var thisData = befdayList[i];
				var html  = '<tr class="text-tooltip">';
					html += '	<td>' + thisData.transferDate + '일</td>';
					html += '	<td class="text-left">' + thisData.bank.bankName + '</td>';
					html += '	<td class="text-left">' + thisData.accountNumber + '</td>';
					html += '	<td class="text-left">' + thisData.accountHolder + '</td>';
					html += '	<td class="text-right">' + common.number.addComma(thisData.amount) + '</td>';
					html += '	<td class="text-left">' + thisData.content + '</td>';
					html += '</tr>';
				$('#befdayCheckMemoTable tbody').append(html);
			}
			if (befdayListLength == 0) {
				$('#befdayCheckMemoTable tbody').append('<tr><td class="text-center" colspan="6">내용이 없습니다.</td></tr>');
			}
			
		} else {
			alert('서버 에러');
		}
		
	}).fail(function (result) {
		alert('서버 에러');
	});
}
</script>

<!-- Begin Page Content -->
<div class="container-fluid">

  	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
	</div>
	
	<!-- Count Row START -->
    <div class="row">
    
    	<!-- 총 소득금액 -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  	<div class="row no-gutters align-items-center">
                    	<div class="col mr-2">
                      		<div class="text-xs font-weight-bold text-success text-uppercase mb-1">총 소득금액</div>
                      		<div class="h5 mb-0 font-weight-bold text-success" id="inTotalAmount">$0</div>
                    	</div>
                    	<div class="col-auto">
                      		<i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    	</div>
                  	</div>
                </div>
            </div>
        </div>
        
    	<!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
        	<div class="card border-left-danger shadow h-100 py-2">
                <div class="card-body">
                  	<div class="row no-gutters align-items-center">
                    	<div class="col mr-2">
                      		<div class="text-xs font-weight-bold text-danger text-uppercase mb-1">총 지출금액</div>
                      		<div class="h5 mb-0 font-weight-bold text-danger" id="outTotalAmount">$0</div>
                    	</div>
	                    <div class="col-auto">
	                      	<i class="fas fa-calendar fa-2x text-gray-300"></i>
	                    </div>
                	</div>
              	</div>
            </div>
        </div>
	
        <!-- Earnings (Monthly) Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  	<div class="row no-gutters align-items-center">
                  		<div class="col mr-2">
                      		<div class="text-xs font-weight-bold text-info text-uppercase mb-1">차액</div>
                      		<div class="h5 mb-0 font-weight-bold text-info" id="diffAmount">$0</div>
                    	</div>
	                    <div class="col-auto">
	                      	<i class="fas fa-calendar fa-2x text-gray-300"></i>
	                    </div>
                  	</div>
				</div>
            </div>
        </div>

        <!-- Pending Requests Card Example -->
        <div class="col-xl-3 col-md-6 mb-4">
        	<div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  	<div class="row no-gutters align-items-center">
                    	<div class="col mr-2">
                      		<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">총 자산</div>
                      		<div class="h5 mb-0 font-weight-bold text-warning" id="totalAssets">$0</div>
                    	</div>
                    	<div class="col-auto">
                      		<i class="fas fa-comments fa-2x text-gray-300"></i>
                   		</div>
                  	</div>
				</div>
            </div>
        </div>
        
    </div>
    <!-- Count Row END -->
    
    <!-- Check Memo Row START -->
    <div class="row">
    	<div class="col-md-6">
    		<div class="card shadow mb-4">
    			<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  	<h6 class="m-0 font-weight-bold text-primary" id="">금일 납일 예정 내역</h6>
                  	<div class="dropdown no-arrow">
                    	<a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      		<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    	</a>
                  	</div>
                </div>
                
                <div class="card-body">
               		<div class="card shadow">
				    	<div class="card-body">
				          	<div class="table-responsive daily-check-memo-table">
				               	<table class="table table-bordered" id="todayCheckMemoTable">
				               		<colgroup>
										<col width="10%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="auto"/>
									</colgroup>
									<thead>
										<tr class="text-tooltip">
											<th class="text-center">이체일</th>
											<th class="text-center">은행</th>
											<th class="text-center">계좌번호</th>
											<th class="text-center">예금주</th>
											<th class="text-center">금액</th>
											<th class="text-center">내용</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
                </div>
    		</div>
    	</div>
    	<div class="col-md-6">
    		<div class="card shadow mb-4">
    			<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  	<h6 class="m-0 font-weight-bold text-primary" id="">지난 미납 내역</h6>
                  	<div class="dropdown no-arrow">
                    	<a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      		<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    	</a>
                  	</div>
                </div>
                
                <div class="card-body">
               		<div class="card shadow">
				    	<div class="card-body">
				          	<div class="table-responsive daily-check-memo-table">
				               	<table class="table table-bordered" id="befdayCheckMemoTable">
				               		<colgroup>
										<col width="10%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="auto"/>
									</colgroup>
									<thead>
										<tr class="text-tooltip">
											<th class="text-center">이체일</th>
											<th class="text-center">은행</th>
											<th class="text-center">계좌번호</th>
											<th class="text-center">예금주</th>
											<th class="text-center">금액</th>
											<th class="text-center">내용</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
                </div>
    		</div>
    	</div>
    </div>
    <!-- Check Memo Row END -->
    
    <!-- Content Row START -->
    <div class="row">
    	<!-- Area Chart -->
        <div class="col-md-12">
        	<div class="card shadow mb-4">
            	<!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  	<h6 class="m-0 font-weight-bold text-primary" id="monthTitle"></h6>
                  	<div class="dropdown no-arrow">
                    	<a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      		<i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                    	</a>
                    	<div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      		<div class="dropdown-header">Dropdown Header:</div>
                   			<a class="dropdown-item" href="#">Action</a>
                   			<a class="dropdown-item" href="#">Another action</a>
                   			<div class="dropdown-divider"></div>
                   			<a class="dropdown-item" href="#">Something else here</a>
                    	</div>
                  	</div>
                </div>
                <!-- Card Body -->
                <div class="card-body">
               		<div class="card shadow col-xl-4 float-left">
				    	<div class="card-body">
				          	<div class="table-responsive">
				               	<table class="table table-bordered" id="chartTable">
				               		<colgroup>
										<col width="40%"/>
										<col width="auto"/>
									</colgroup>
									<tbody>
										<tr>
											<th colspan="2">데이터가 없습니다.</th>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
                  	<div class="col-xl-8 float-right">
						<div id="chartdiv"></div>
					</div>
                </div>
            </div>
        </div>
	</div>
	<!-- Content Row END -->
	
</div>