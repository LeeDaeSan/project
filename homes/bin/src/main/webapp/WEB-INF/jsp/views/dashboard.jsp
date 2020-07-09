<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/lib/amChart/core.js"></script>
<script type="text/javascript" src="/lib/amChart/charts.js"></script>
<script type="text/javascript" src="/lib/amChart/animated.js"></script>

<style>
#chartdivBar, #chartdiv {
  width: 100%;
  height: 370px;
}
#chartTable td, #chartTable th {
	padding : 7px 6px 7px 6px !important;
}
</style>
<script type="text/javascript">
//현재 달
var nowMonth = (new Date().getMonth() + 1);

am4core.ready(function() {
	
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
				
				// 소득 총액
				var inTotalAmount = 0;
				// 지출 총액
				var outTotalAmount = 0;
				
				var list 		= result.list;
				var listLength 	= list.length;
				var chartList 	= [];
				var html 		= '';
				for (var i = 0; i < listLength; i++) {
					var thisData = list[i];
					
					if (thisData.amountType != 'IN') {
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
						outTotalAmount += thisData.totalAmount;
					} else {
						inTotalAmount += thisData.totalAmount;
					}
				}
				
				// 데이터가 없을 때
				if (listLength == 0) {
					html = '<tr><th colspan="2">데이터가 없습니다.</td></tr>';
				}
				
				$('#chartTable tbody').empty().append(html);
				
				// 소득 총액 bind
				mountCount(inTotalAmount, $('#inTotalAmount'));
				// 지출 총액 bind
				mountCount(outTotalAmount, $('#outTotalAmount'));
				// 차액 bind
				var diffAmount = inTotalAmount - outTotalAmount;
				mountCount(diffAmount, $('#diffAmount'));
				// 총 자산 bind
				var totalAssets = result.totalAssets;
				mountCount(totalAssets, $('#totalAssets'));
				
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

/**
 * 금액 애니메이션
 
 */
function mountCount (num, thisTag) {
	$({ val : 0 }).animate({ val : num }, {
		duration 	: 1000,
		step 		: function () {
			thisTag.text(common.number.addComma(Math.floor(this.val)));
		},
		complete 	: function () {
			thisTag.text(common.number.addComma(Math.floor(this.val)));
		}
	});
}
</script>

<!-- Begin Page Content -->
<div class="container-fluid">

  	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
	</div>
	
	<!-- Content Row START -->
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
    <!-- Content Row END -->
    
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