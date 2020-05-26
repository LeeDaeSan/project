<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/lib/amChart/themes/animated.js"></script>

<script>
am4core.ready(function () {
	
	
	
	var chartApp = new Vue({
		el 		: '#chartApp',
		data 	: {
			level : 1,
			
		},
		
		methods : {
			
			list : function () {
				var thisApp = this;
				var level = thisApp.level;
				level = $('#level').val();
				
				var startDate = $("input[name='daterangepicker_start']").val();
				var endDate   = $("input[name='daterangepicker_end']").val();
				
				if ( startDate > endDate ){
					
					alert("기간을 확인하세요.");
					$("input[name='daterangepicker_start']").focus();
					
					return false;
				}
				
				var params = new URLSearchParams();
				params.append('searchStartDate'	, converter.string.replaceAll(startDate, "/", ""));
				params.append('searchEndDate'	, converter.string.replaceAll(endDate, "/", ""));
				params.append('level'			, level);
				
				if (level == '2') {
					params.append('parentIdx', $('#level1Select').val());
				} else if (level == '3') {
					
					var level2Idx = $('#level2Select').val();
					if (level2Idx) {
						params.append('parentIdx', $('#level2Select').val());
					} else if (level2Idx == 0) {
						alert('등록된 소분류 코드가 없습니다.');
						return false;
					}
				}
				
				// [필수설정]
				axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
				// Promise
				axios.post('/houseHoldItem/selectOfStatistics', params).then(res => {
					
					if (res.status == 200) {
						
						chartMake('chartDiv01', res.data.level1List);
						
					} else {
						alert('목록 호출 실패');
					}
				});
			}
		}
	});
	
	var searchApp = new Vue({
		el 		: '#searchApp',
		data 	: {
			level			: 1,
			parentIdx		: 0,
		},
		methods : {
			
			// 초기 설정
			init : function () {
				
				$('input[name="daterangepicker_start"]').val(converter.date.month.firstDay(new Date(), '/'));
				$('input[name="daterangepicker_end"]').val(converter.date.month.lastDay(new Date(), '/'));
				
				// 목록 조회
				chartApp.list();
			},
			
			typeSelect : function () {
				var thisApp = this;
				var level 	= thisApp.level;
				
				var params = new URLSearchParams();
				params.append('level'		, level);
				params.append('parentIdx'	, thisApp.parentIdx);
				
				axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
				axios.post('/houseHoldItem/selectOfPopup', params).then(response => {
					if (response.status == 200) {

						var html = '';
						
						$.each(response.data.list, function () {
							html += '<option value="' + this.itemIdx + '">' + this.itemName + '</option>';							
						});
						
						if (response.data.list.length == 0) {
							html = '<option value="0">선택 없음</option>';	
						}
						
						if (level == 1) {
							$('#level1Select').empty().append(html);	
						} else if (level == 2) {
							$('#level2Select').empty().append(html);
						}
						
					}
				});
			}
		}
	});
	
	// 검색 초기 설정
	searchApp.init();
	
	$('#btnSearch').unbind('click').click(function (e) {
		e.preventDefault();
		chartApp.list();
	});
	
	// 타입 select change event
	$('#level').change(function () {
		
		$('.level_div').hide();
		
		// 대분류
		if ($(this).val() == '1') {
			
		// 중분류
		} else if ($(this).val() == '2') {
			
			searchApp.typeSelect();
			
			$('.level_div:eq(0)').show();
			
		// 소분류
		} else if ($(this).val() == '3') {
			
			// 중분류 조회
			searchApp.level = 1;
			searchApp.parentIdx = $('#level').val();
			searchApp.typeSelect();

			setTimeout(function () {
				// 소분류 조회
				searchApp.level = 2;
				searchApp.parentIdx = $('#level1Select').val();
				searchApp.typeSelect();
			}, 100);
			
			
			$('.level_div').show();
		}
		
	});

	// 중분류 change event
	$('#level1Select').change(function () {

		// 소분류인 경우
		if ($('#level').val() == '3') {
			searchApp.level = 2;
			searchApp.parentIdx = $(this).val();
			searchApp.typeSelect();
		}
	});
	
});

function chartMake (id, list) {
	am4core.useTheme(am4themes_animated);
	
	// Create chart instance
	var chart = am4core.create(id, am4charts.XYChart);
	
	//chart.scrollbarX = new am4core.Scrollbar();
	
	chart.data = list;
	
	// Create axes
	var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
		categoryAxis.dataFields.category 						= "country";
		categoryAxis.renderer.grid.template.location 			= 0;
		categoryAxis.renderer.minGridDistance 					= 30;
		categoryAxis.renderer.labels.template.horizontalCenter 	= "right";
		categoryAxis.renderer.labels.template.verticalCenter 	= "middle";
		categoryAxis.renderer.labels.template.rotation 			= 310;
		categoryAxis.tooltip.disabled 							= true;
		categoryAxis.renderer.minHeight 						= 110;
		
	var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
		valueAxis.renderer.minWidth = 50;

	// Create series
	var series = chart.series.push(new am4charts.ColumnSeries());
		series.sequencedInterpolation 		= true;
		series.dataFields.valueY 			= "visits";
		series.dataFields.categoryX 		= "country";
		series.tooltipText 					= "[{categoryX}: bold]{valueY}[/]";
		series.columns.template.strokeWidth = 0;
		series.tooltip.pointerOrientation 	= "vertical";

		series.columns.template.column.cornerRadiusTopLeft 	= 10;
		series.columns.template.column.cornerRadiusTopRight = 10;
		series.columns.template.column.fillOpacity 			= 0.8;

	// on hover, make corner radiuses bigger
	var hoverState = series.columns.template.column.states.create("hover");
		hoverState.properties.cornerRadiusTopLeft 	= 0;
		hoverState.properties.cornerRadiusTopRight 	= 0;
		hoverState.properties.fillOpacity 			= 1;

	series.columns.template.adapter.add("fill", function(fill, target) {
	  return chart.colors.getIndex(target.dataItem.index);
	});

	// Cursor
	chart.cursor = new am4charts.XYCursor();
	
}
</script>

<style>
#chartDiv01 {
  width: 100%;
  height: 365px;
  max-width: 100%;
}

.
</style>

<!-- search START -->
<div id="searchApp" class="row pdt20">
	<div class="col-md-12">
		<div class="content-panel pdt0 pdb0">
			<div class="weather-2-header panel-header">
				<div class="row">
					<div class="col-sm-6 col-xs-6">
						<p><i class="fa fa-search"></i>&nbsp;검색</p>
					</div>
				</div>
			</div>
			<table class="table mgnb0">
				<colgroup>
					<col style="width: 10%" />
					<col style="width: 40%" />
					<col style="width: 10%" />
					<col style="width: 40%" />
				</colgroup>
				<tr>
					<td class="border-top0 lineHeight20"><strong>타입</strong></td>
					<td class="border-top0">
						<div class="col-md-3 pdl0">
							<select class="form-control" id="level">
								<option value="1">대분류</option>
								<option value="2">중분류</option>
								<option value="3">소분류</option>
							</select>
						</div>
						<div class="col-md-3 pdl0 level_div" style="display:none;">
							<select class="form-control" id="level1Select">
							</select>
						</div>
						<div class="col-md-3 pdl0 level_div" style="display:none;">
							<select class="form-control" id="level2Select">
							</select>
						</div>
					</td>
					
					<td class="lineHeight20"><strong>기간</strong></td>
					<td>
						<div class="pdl0">
							<div class="input-group input-large fl input-group-date" data-date="01/01/2014" data-date-format="yyyy/mm/dd">
								<input type="text" class="form-control dpd1" name="daterangepicker_start">
								<span class="input-group-addon">To</span>
								<input type="text" class="form-control dpd2" name="daterangepicker_end">
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<div class="tr mgnt20 mgnb20">
	<button type="button" class="btn btn-outline-success btn-md" id="btnSearch">검색</button>
</div>
<!-- search END -->


<div class="row pdt20">
	<div class="col-md-12">
	
		<div id="chartApp">
			<div>대분류 통계 정보</div>
			<div id="chartDiv01"></div>
		</div>
	
	</div>
</div>