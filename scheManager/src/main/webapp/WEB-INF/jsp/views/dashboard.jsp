<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/lib/amChart/themes/animated.js"></script>

<style>
#chartDiv {
  width: 100%;
  height: 265px;
  max-width: 100%;
}
</style>

<script>
am4core.ready(function () {
	
	am4core.useTheme(am4themes_animated);
	
	var chart = am4core.create('chartDiv', am4charts.XYChart);
	chart.paddingRight = 20;

	var data = [];
	var visits = 10;
	for (var i = 1; i < 10; i++) {
	  visits += Math.round((Math.random() < 0.5 ? 1 : -1) * Math.random() * 10);
	  data.push({ date: new Date(2018, 0, i), value: visits });
	}
	
	chart.data = data;

	var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
		dateAxis.renderer.grid.template.location = 0;
		dateAxis.minZoomCount = 5;

		// this makes the data to be grouped
		dateAxis.groupData = true;
		dateAxis.groupCount = 500;

	var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

	var series = chart.series.push(new am4charts.LineSeries());
		series.dataFields.dateX 				= "date";
		series.dataFields.valueY 				= "value";
		series.tooltipText 						= "{valueY}";
		series.tooltip.pointerOrientation 		= "vertical";
		series.tooltip.background.fillOpacity 	= 0.5;

	chart.cursor = new am4charts.XYCursor();
	chart.cursor.xAxis = dateAxis;

});
</script>
<body>

<div>월별 가계 정보</div>
<div id="chartDiv"></div>
<!-- 
	<! -- 수정 Button -- >
	<div class="">
		<span class="width200 display_ib">수정 Button</span>
		<button type="button" class="btn btn-warning">Warning</button>
		<button type="button" class="btn btn-outline-warning">Warning</button>
	</div>
	
	<br>
	
	삭제 Button
	<div class="">
		<span class="width200 display_ib">삭제 Button</span>
		<button type="button" class="btn btn-danger">Danger</button>
		<button type="button" class="btn btn-outline-danger">Danger</button>
	</div>
	
	<br>
	
	등록, 저장, 상세 Button
	<div class="">
		<span class="width200 display_ib">등록, 저장, 상세 Button</span>
		<button type="button" class="btn btn-primary">Primary</button>
		<button type="button" class="btn btn-outline-primary">Primary</button>
	</div>

	<br>

	<div class="">
		<span class="width200 display_ib">기타 Button</span>
		<button type="button" class="btn btn-info">Info</button>
		<button type="button" class="btn btn-default">Default</button>
		<button type="button" class="btn btn-secondary">Secondary</button>
		<button type="button" class="btn btn-success">Success</button>
		<button type="button" class="btn btn-light">Light</button>
		<button type="button" class="btn btn-dark">Dark</button>
		<button type="button" class="btn btn-link">Link</button>
	</div>
	
	<br>
	
	<div>
		<span class="width200 display_ib">기타 outline Button</span>
		<button type="button" class="btn btn-outline-info">Info</button>
		<button type="button" class="btn btn-outline-secondary">Secondary</button>
		<button type="button" class="btn btn-outline-success">Success</button>
		<button type="button" class="btn btn-outline-light">Light</button>
		<button type="button" class="btn btn-outline-dark">Dark</button>
	</div>
 -->
</body>
