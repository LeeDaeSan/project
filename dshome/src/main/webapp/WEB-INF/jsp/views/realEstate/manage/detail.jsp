<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../../../../lib/sbadmin2/css/all.min.css" />
	<link rel="stylesheet" href="../../../../lib/sbadmin2/css/sb-admin-2.min.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  
  
	<script src="/webjars/jquery/3.3.1/dist/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<style>
.custom-combobox {
	position: relative;
	display: inline-block;
}

.custom-combobox-toggle {
	position: absolute;
	top: 0;
	bottom: 0;
	margin-left: -1px;
	padding: 0;
}

.custom-combobox-input {
	margin: 0;
	padding: 5px 10px;
}

.ui-menu {
	max-height : 300px;
	overflow-y : auto;
}

</style>

<script>
$(function(){
	
	fn_setDateBox();
	
	var urlParams	 = new URLSearchParams(window.location.search);
	var urlParamType = urlParams.get("type");
	var urlParamIdx  = urlParams.get("idx");
	
	// 지하철 라인 조회
	fn_retrieveStationLine();
	
	// 지하철 역 조회
	fn_retrieveStation($("#stationLineNo").val());
	
	if ( urlParamType == "U" ){
		fn_retrieveDetail(urlParamIdx);
		$("#delete").show();
	} else {
		$("#delete").remove();
	}
	
	// 저장 버튼 클릭 이벤트
	$("#save").unbind("click").click(function(){
		fn_save(urlParamType == "I" ? "I" : "U", urlParamIdx);
	});
	
	// 삭제 버튼 클릭 이벤트
	$("#delete").unbind("click").click(function(){
		fn_save("D", urlParamIdx);
	});
	
	// 취소 버튼 클릭 이벤트
	$("#cancel").unbind("click").click(function(){
		location.href = "../manage/list";
	});
	
	// 공용면적 평수 계산
	$("#supplySpaceChange").unbind("click").click(function(){
		
		var supplySpace = $("#supplySpace").val() / 3.3058;
		
		$(this).find("span").text(supplySpace.toFixed(2));
	});
	
	// 전용면적 평수 계산
	$("#exclusiveSpaceChange").unbind("click").click(function(){
		
		var exclusiveSpace = $("#exclusiveSpace").val() / 3.3058;
		
		$(this).find("span").text(exclusiveSpace.toFixed(2));
		
	});
	
	// 총 금액 계산
	$("#brokerFee, #acquisitionTax, #propertyTotalTax").focusout(function(){
		$("#totalPrice").val(common.number.addComma(fn_totalTax()));
	});
	
	// 공통코드 조회 [directionType] : 방향(거실기준)
	fn_retrieveCommCode("direction","directionType");
	
	// 공통코드 조회 [dealType] : 거래타입
	fn_retrieveCommCode("deal","dealType");
	
	// 지하철역 selectbox 변경 이벤트
	$("#stationLineNo").change(function(){
		fn_retrieveStation($("#stationLineNo :selected").val());
	});
	
	// 주소지 시도/구군/동 조회
	fn_retrieveCityList(null, 0);
	
	// 시/도 selectbox 변경 이벤트
	$("#sidoList").change(function(){
		
		$("#gugunList").empty().append(fn_option('', "-선택-", 1));
		$("#dongList").empty().append(fn_option('', "-선택-", 2));
		
		fn_retrieveCityList($(this).find(":selected").val(), "1");
		
	});
	
	// 구/군 selectbox 변경 이벤트
	$("#gugunList").change(function(){
		
		$("#dongList").empty().append(fn_option('', "-선택-", 2));
		
		fn_retrieveCityList($(this).find(":selected").val(), "2");
		
	});
	
	// 동 selectbox 변경 이벤트
	$("#dongList").change(function(){
		fn_retrieveAptList($(this).find(":selected").val());
	});
	
	// 자동입력 버튼 클릭 이벤트
	$("#auto").unbind("click").click(function(){
		
		$.widget( "custom.combobox", {
			_create: function() {
				this.wrapper = $("<span>")
					.addClass("custom-combobox")
					.insertAfter(this.element);
				this.element.hide();
				this._createAutocomplete();
				this._createShowAllButton();
			},

			_createAutocomplete: function() {
				var selected = this.element.children(":selected"),
					value = selected.val() ? selected.text() : "";
				this.input = $("<input>").appendTo(this.wrapper)
					.val(value)
					.attr("title", "")
					.attr("placeholder", "선택")
					.addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
					.autocomplete({
						delay: 0,
						minLength: 0,
						source: $.proxy(this, "_source")
					})
					.tooltip({
						classes: {
							"ui-tooltip": "ui-state-highlight"
						}
					});

				this._on( this.input, {
					autocompleteselect: function( event, ui ) {
						ui.item.option.selected = true;
						this._trigger("select", event, {
							item: ui.item.option
						});
						
						$("#complexName").val(ui.item.option.text);
						$("#aptLatitude").val(ui.item.option.attributes[1].value);
						$("#aptLongitude").val(ui.item.option.attributes[2].value);
						
						fn_retrieveAptInfo(ui.item.option.value, $("#aptLatitude").val(), $("#aptLongitude").val());
						
					},

					autocompletechange: "_removeIfInvalid"
					
				});
			},

			_createShowAllButton: function() {
				
				var input	= this.input,
					wasOpen = false;

				$( "<a>" )
					.attr("tabIndex", -1)
					.attr("title", "Show All Items")
					.tooltip()
					.appendTo( this.wrapper )
					.button({
						icons: {
							primary: "ui-icon-triangle-1-s"
						},
						text: false
					})
					.removeClass( "ui-corner-all" )
					.addClass("custom-combobox-toggle ui-corner-right")
					.on("mousedown", function() {
						wasOpen = input.autocomplete("widget").is(":visible");
					})
					.on( "click", function() {
						input.trigger("focus");

						// Close if already visible
						if (wasOpen) return;

						// Pass empty string as value to search for, displaying all results
						input.autocomplete("search", "");
					});
			},

			_source: function(request, response){
				var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
				response(this.element.children("option").map(function() {
					var text = $(this).text();
					if (this.value && (!request.term || matcher.test(text)))
						return {
							label : text,
							value : text,
							option: this
						};
				}) );
			},

			_removeIfInvalid: function( event, ui ) {

				// Selected an item, nothing to do
				if (ui.item) return;

				// Search for a match (case-insensitive)
				var value = this.input.val(),
					valueLowerCase = value.toLowerCase(),
					valid = false;
				this.element.children( "option" ).each(function() {
					if ( $( this ).text().toLowerCase() === valueLowerCase ) {
						this.selected = valid = true;
						return false;
					}
				});

				// Found a match, nothing to do
				if (valid) return;

				// Remove invalid value
	/* 			this.input
					.val("")
					.attr("title", value + " didn't match any item")
					.tooltip("open");
				this.element.val("");
				this._delay(function() {
					this.input.tooltip("close").attr("title", "");
				}, 2500 );
				this.input.autocomplete("instance").term = ""; */
			},

			_destroy: function() {
				this.wrapper.remove();
				this.element.show();
			}
		});
		
		$("#combobox").combobox();
		$(".auto").show();
		
	});
	
	// 수동입력 버튼 클릭 이벤트
	$("#manual").unbind("click").click(function(){
		$(".auto").hide();
	});
	

});

/**
 * @description 공통코드 조회
 * @param		{String} type
 * @param		{String} compId
 * return		N/A
*/
function fn_retrieveCommCode(type, compId){

	$.ajax({
		
		url		 	: "/comm/code/list/",
		data		: {type : type},
		type	 	: "GET",
		dataType 	: "JSON",
		async	 	: false
		
	}).done(function(result){

		if ( result.status ){

			var html = "";
			var resultData = result.list;
			var dataLength = resultData.length;
			
			html += "<option>" + (dataLength === 0 ? '선택없음' : '선택') + "</option>";

			if ( dataLength != 0 ){
				
				for (var i in resultData){
					html += "<option value='" + resultData[i].code + "'>" + resultData[i].name + "</option>";
				}
				
			}
			
			$("#" + compId).empty().append(html);
			
		} else {
			
			alert("Server Error!!");
			return false;
			
		}
		
	}).fail(function(){
		
		alert("Server Error!!");
		return false;
		
	});
	
}

/**
 * @description 등록/수정/삭제
 * @param		{String} type
 * return		N/A
*/
function fn_save(type, memberRealEstateIdx){
	
	var param = {
		
		houseName			: $.trim($("#complexName").val()),										// 매물명
		address				: $.trim($("#address").val()),											// 매물 주소
		stationLineNo		: $("#stationLineNo").val(),											// 지하철 호선
		stationNo			: $.trim($("#stationNo").val()),										// 지하철 명
		stationRange		: $.trim($("#stationRange").val()),										// 매물과 지하철과의 거리
		useApproveDate		: $("#year").val() + $("#month").val() + $("#day").val(),				// 사용승인일
		totalHouseholdCount	: $.trim($("#totalHouseholdCount").val()),								// 총 세대 수
		parkingPossibleCount: $.trim($("#parkingPossibleCount").val()),								// 총 주차 대수
		directionType		: $("#directionType :selected").val(),									// 방향(거실기준)
		bay					: $.trim($("#bay").val()),												// Bay
		supplySpace			: $.trim($("#supplySpace").val()),										// 공용면적
		exclusiveSpace		: $.trim($("#exclusiveSpace").val()),									// 전용면적
		dealType			: $("#dealType :selected").val(),										// 거래타입
		dealPrice			: $.trim($("#dealPrice").val().replaceAll(",", "")),					// 거래가격
		brokerFee			: $.trim($("#brokerFee").val().replaceAll(",", "")),					// 중개보수
		acquisitionTax		: $.trim($("#acquisitionTax").val().replaceAll(",", "")),				// 취득세
		propertyTotalTax	: $.trim($("#propertyTotalTax").val().replaceAll(",", "")),				// 보유세
		remark				: $("#remark").val(),													// 비고
		type				: type,																	// 타입(I:등록/U:수정/D:삭제)
		memberRealEstateIdx	: memberRealEstateIdx
			
	}
	
	var resultType = "";
	
	if ( type == "I" ){
		resultType = "등록";
	} else if ( type == "U" ){
		resultType = "수정";
	} else if ( type == "D" ) {
		resultType = "삭제";
	}
	
	if ( confirm(resultType + " 하시겠습니까?") ){
		
		$.ajax({
			
			url		 : "/rest/realEstate/merge",
			type	 : "POST",
			data	 : param,
			dataType : "JSON"
			
		}).done(function(result){
			
			if (result.status) {
				
				alert(resultType + " 되었습니다.");
				
				if (type == "D"){
					location.href = "../manage/list";
				} else {
					location.reload();
				}
				
			} else {
				alert("서버 에러");
				return false;
			}
			
		}).fail(function(){
			
			alert("서버 에러");
			return false;
			
		});
		
	}
	
}

/**
 * @description 사용자 부동산 상세정보 조회
 * @param		{Number} idx
 * return		N/A
*/
function fn_retrieveDetail(idx){
		
	$.ajax({
		
		type	 : "POST",
		url		 : "/rest/realEstate/detail",
		dataType : "JSON",
		data	 : { memberRealEstateIdx : idx },
		
	}).done(function(result){
		
		if ( result.status ){
			
			var resultData = result.detail;
			
			fn_retrieveStation(resultData.stationLineNo);
			
			$("#complexName").val(resultData.houseName),											// 매물명
			$("#address").val(resultData.address),													// 매물 주소
			$("#stationLineNo").val(resultData.stationLineNo),										// 지하철 호선
			$("#stationNo").val(resultData.stationNo),												// 지하철 명
			$("#stationRange").val(resultData.stationRange),										// 매물과 지하철과의 거리
			$("#year").val(resultData.useApproveDate.substr(0,4));									// 사용승인일(년도)
			$("#month").val(resultData.useApproveDate.substr(4,2));									// 사용승인일(월)
			$("#day").val(resultData.useApproveDate.substr(6,2));									// 사용승인일(일)
			$("#totalHouseholdCount").val(resultData.totalHouseholdCount),							// 총 세대 수
			$("#parkingPossibleCount").val(resultData.parkingPossibleCount),						// 총 주차 대수
			$("#directionType").val(resultData.directionType),										// 방향(거실기준)
			$("#bay").val(resultData.bay),															// Bay
			$("#supplySpace").val(resultData.supplySpace),											// 공용면적
			$("#exclusiveSpace").val(resultData.exclusiveSpace),									// 전용면적
			$("#dealType").val(resultData.dealType),												// 거래타입
			$("#dealPrice").val(common.number.addComma(resultData.dealPrice)),						// 거래가격
			$("#brokerFee").val(common.number.addComma(resultData.brokerFee)),						// 중개보수
			$("#acquisitionTax").val(common.number.addComma(resultData.acquisitionTax)),			// 취득세
			$("#propertyTotalTax").val(common.number.addComma(resultData.propertyTotalTax)),		// 보유세
			$("#remark").val(resultData.remark),													// 비고
			$("#totalPrice").val(common.number.addComma(fn_totalTax()))								// 총 세금
			
		} else {
			
			alert("서버 에러");
			return false;
			
		}
		
	}).fail(function(data){
		alert("서버 에러");
		return false;
	});
	
}

/**
 * @description 총 세금 계산
 * return		totalTaxPrice
*/
function fn_totalTax(){
	
	var brokerFee		 = parseInt($("#brokerFee").val().replaceAll(",", "") || 0 );
	var acquisitionTax	 = parseInt($("#acquisitionTax").val().replaceAll(",", "") || 0);
	var propertyTotalTax = parseInt($("#propertyTotalTax").val().replaceAll(",", "") || 0);

	return brokerFee + acquisitionTax + propertyTotalTax;
	
}

// select box 월 / 일
function fn_setDateBox(){

	// 월 뿌려주기(1월부터 12월)
	for (var i = 1; i <= 12; i++) {
		$("#month").append("<option value='"+ (i >= 10 ? i : "0" + i) +"'>" + (i >= 10 ? i : "0" + i) +"</option>");
	}
	
	// 일 뿌려주기(1일부터 31일)
	for (var i = 1; i <= 31; i++) {
		$("#day").append("<option value='"+ (i >= 10 ? i : "0" + i) +"'>" + (i >= 10 ? i : "0" + i) + "</option>");
	}
	
}

/**
 * @description 지하철 라인 조회
 * return		N/A
*/
function fn_retrieveStationLine(){

	$.ajax({
		
		url		 : "/rest/stationInfo/list",
		type	 : "GET",
		dataType : "JSON",
		async	 : false
		
	}).done(function(result){
		
		if (result.status){
			
			var resultData = result.list;
			var dataLength = result.list.length;
			var html = "";

			$("#stationLineNo").empty();
		
			html += "<option>" + (dataLength === 0 ? '선택없음' : '호선 선택') + "</option>";
			
			if ( dataLength != 0 ){
				
				for ( var i in resultData ){
					html += "<option value=" + resultData[i].stationLineNo + ">" + resultData[i].stationLineName + "</option>";
				}
				
			}
				
			$("#stationLineNo").append(html);
			
		}
		
	}).fail(function(data){
		alert("서버 에러");
		return false;
	});
	
}

/**
 * @description 지하철 역 조회
 * @param		{String} stationLineNo
 * return		N/A
*/
function fn_retrieveStation(stationLineNo){
	
	$.ajax({
		
		url		 : "/rest/stationInfo/detail",
		type	 : "GET",
		dataType : "JSON",
		data	 : { stationLineNo : stationLineNo },
		async	 : false
		
	}).done(function(result){
		
		if ( result.status ){
		
			$("#stationNo").empty();
			
			var resultData = result.detail;
			var dataLength = result.detail.length;
			var html = "";
			
			html += "<option>" + (dataLength === 0 ? '선택없음' : '역 선택') + "</option>";

			if ( dataLength != 0 ){
				
				for ( var i in resultData ){
					html += "<option value=" + resultData[i].stationNo + ">" + resultData[i].stationName + "</option>";
				}
			}
				
			$("#stationNo").append(html);
			
		} else {
			
			alert("서버 에러");
			return false;
		}
		
	}).fail(function(){
		
		alert("서버에러");
		return false;
		
	});
	
}

 /**
  * @description 시도/구군/동 조회
  * @param		{String} cortarNo
  * @param		{String} depth
  * return		N/A
 */
function fn_retrieveCityList(cortarNo, depth){
	
	$.ajax({
		
		url		 : "http://localhost:8080/rest/cityLocation/list",
		type	 : "GET",
		data	 : {cortarNo : cortarNo , depth : depth},
		dataType : "JSON"
		
	}).done(function(result){
		
		if (result.status){
			
			var resultData = result.list;
			
			if ( depth == 0 ){
				
				for ( var i in resultData ){
					$("#sidoList").append(fn_option(resultData[i].cortarNo, resultData[i].cortarName, resultData[i].depth));	
				}
				
			} else if ( depth == 1 ){
				
				for ( var i in resultData ){
					$("#gugunList").append(fn_option(resultData[i].cortarNo, resultData[i].cortarName, resultData[i].depth));	
				}
				
			} else {
				
				for ( var i in resultData ){
					$("#dongList").append(fn_option(resultData[i].cortarNo, resultData[i].cortarName, resultData[i].depth));	
				}
				
			}
		} else {
			alert("서버 에러");
			return false;
		}
		
	}).fail(function(){
		
		alert("서버 에러");
		return false;
	});
	
}

/**
 * @description 시도/구군/동 selectbox
 * @param		{String} cortarNo
 * @param		{String} cortarName
 * @param		{String} depth
 * return		N/A
*/
function fn_option(cortarNo, cortarName, depth){
	 
	$("#combobox").empty();
	$(".custom-combobox-input, #aptLatitude, #aptLongitude").val("");
	
	return "<option value='" + cortarNo + "' depth='" + depth + "'>" + cortarName + "</option>";
}

/**
 * @description 지하철 리스트 selectbox
 * @param		{String} dongCode
 * return		N/A
*/
function fn_retrieveAptList(dongCode){
	
	if (dongCode){
		
		$.ajax({
			
			url		 : "http://127.104.65.149:8009/apt/list/" + dongCode,
			type	 : "GET",
			dataType : "JSON"
			
		}).done(function(result){
			
			if (result) {
				
				$("#combobox").empty();
				
				if ( result.status == 'SUCCESS' ) {

					var aptList = result.result.complexList;
					
					for ( var i in aptList ){
						$("#combobox").append('<option value="' + aptList[i].complexNo + '"' + "latitude='" + aptList[i].latitude + "'" + "longitude='" + aptList[i].longitude + "'>" + aptList[i].complexName + "</option>");
					}
				
				}
			}
			
		}).fail(function(){
			alert("서버 에러");
			return false;
		});
		
	}
	
}

/**
 * @description 아파트 정보 selectbox
 * @param		{String} aptCode
 * @param		{String} latitude
 * @param		{String} longitude
 * return		N/A
*/
function fn_retrieveAptInfo (aptCode, latitude, longitude){
	
	$.ajax({
		
		url		 : "http://127.104.65.149:8009/apt/info/" + aptCode + "/" + latitude + "/" + longitude,
		type	 : "GET",
		dataType : "JSON"
		
	}).done(function(result){
		
		if (result.status){
			
			var data = result.result;

			$("#year").val(data.useApproveYmd.substring(0,4));
			$("#month").val(data.useApproveYmd.substring(4,6));
			$("#day").val(data.useApproveYmd.substring(6,8));
			$("#totalHouseholdCount").val(data.totalHouseHoldCount);
			$("#address").val($("#sidoList :selected").text() + " " + $("#gugunList :selected").text() + " "+ $("#dongList :selected").text());
			
		}
	}).fail(function(){
		
		alert("서버 에러");
		return false;
		
	});
}

</script>
<body>

	<div id="default" style="margin: 20px">
	
		<!-- 기본 정보 START -->
		<div class="card mb-4">
			<div class="card-header list-inline-item">기본 정보
				<div class="text-right list-inline-item ml-10">
					<button type="button" class="btn btn-outline-secondary" id="manual">수동입력</button>
					<button type="button" class="btn btn-outline-secondary" id="auto">자동입력</button>
				</div>
			</div>
			<div class="card-body">
				<div class="sbp-preview">
					<div class="bd-example">
						<form class="">
								
							<div class="form-group row auto" style="display: none;">
								<label class="col-sm-2 col-form-label" for="">주소지 선택</label>
								<div class="col-md-2">
									<select class="form-control" id="sidoList">
										<option>-선택-</option>
									</select>
								</div>
								<div class="col-md-2">
									<select class="form-control" id="gugunList">
										<option>-선택-</option>
									</select>
								</div>
								<div class="col-md-2">
									<select class="form-control" id="dongList">
										<option>-선택-</option>
									</select>
								</div>
							</div>
							
							<div class="form-group row auto" style="display: none;">
								<label class="col-sm-2 col-form-label" for="">아파트 선택</label>
								<div class="col-sm-6">
									<div class="ui-widget">
			 							<select id="combobox">
										</select>
									</div>
									<div>
										<input type="hidden" id="aptLatitude">
										<input type="hidden" id="aptLongitude">
									</div>
								</div>
							</div>
								
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="complexName">아파트명</label>
								<div class="col-sm-6">
									<input class="form-control" id="complexName">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="address">주소지</label>
								<div class="col-sm-6">
									<input class="form-control" id="address">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="station">지하철역</label>
								<div class="col-md-2">
									<select class="form-control" id="stationLineNo">
									</select>
								</div>
								<div class="col-md-2">
									<select class="form-control" id="stationNo">
									</select>
								</div>
								<div class="col-md-2">
									<input class="form-control" id="stationRange" placeholder="거리(m)">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="useApproveDate">사용승인일</label>
								<div class="col-md-2">
									<input class="form-control" id="year" placeholder="년도(yyyy)">
								</div>
								<div class="col-md-2">
									<select class="form-control" id="month">
										<option>월 선택</option>
									</select>
								</div>
								<div class="col-md-2">
									<select class="form-control" id="day">
										<option>일 선택</option>
									</select>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="totalHouseholdCount">총 세대/주차</label>
								<div class="col-sm-2">
									<input class="form-control" id="totalHouseholdCount" placeholder="총 세대 수">
								</div>
								<div class="col-sm-4">
									<input class="form-control" id="parkingPossibleCount" placeholder="총 주차 대수">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 기본 정보 END -->
		
		<!-- 상세 정보 START -->
		<div class="card mb-4">
			<div class="card-header">상세 정보</div>
			<div class="card-body">
				<div class="sbp-preview">
					<div class="bd-example">
						<form class="">
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="directionType">방향(거실기준)</label>
								<div class="col-sm-3">
									<select class="form-control" id="directionType">
									</select>
								</div>
								<div class="col-sm-3">
									<input type="text" class="form-control" id="bay" placeholder="Bay"/>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="space">면적</label>
								<div class="input-group col-sm-3">
									<input type="text" class="form-control" placeholder="공용면적(m2)" id="supplySpace">
									<div class="input-group-append">
										<span class="input-group-text" id="supplySpaceChange"><span></span> 평 <i class="fas fa fa-refresh fa-sm"></i></span>
									</div>
								</div>
								<div class="input-group col-sm-3">
									<input type="text" class="form-control" placeholder="전용면적(m2)" id="exclusiveSpace">
									<div class="input-group-append">
										<span class="input-group-text" id="exclusiveSpaceChange"><span></span> 평 <i class="fas fa fa-refresh fa-sm"></i></span>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="dealType">거래가격</label>
								<div class="col-md-3">
									<select class="form-control" id="dealType">
									</select>
								</div>
								<div class="col-md-3">
									<input class="form-control" id="dealPrice" placeholder="(억)">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="articleTax">세금정보</label>
								<div class="col-sm-2">
									<input class="form-control" id="brokerFee" placeholder="중개보수(VAT 별도)">
								</div>
								<div class="col-sm-2">
									<input class="form-control" id="acquisitionTax" placeholder="취득세">
								</div>
								<div class="col-sm-2">
									<input class="form-control" id="propertyTotalTax" placeholder="보유세">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="totalPrice">총 금액</label>
								<div class="col-sm-6">
									<input class="form-control" id="totalPrice" placeholder="거래가+중개보수+취득세+보유세" readonly>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="remark">비고</label>
								<div class="col-sm-6">
									<textarea class="form-control" id="remark"></textarea>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 상세 정보 END -->
		
		<!-- 버튼 START -->
		<div class="align-items-end mb-4 text-right">
			<button type="button" class="d-none d-sm-inline-block btn btn-danger shadow-sm" id="cancel">
				<i class="fas fa fa-th-list fa-sm text-white-50"></i> 목록
			</button>
			<button type="button" class="d-none d-sm-inline-block btn btn-warning shadow-sm" id="delete" style="display: none !important;">
				<i class="fas fa-check fa-sm text-white-50"></i> 삭제
			</button>
			<button type="button" class="d-none d-sm-inline-block btn btn-primary shadow-sm" id="save">
				<i class="fas fa fa-check fa-sm text-white-50"></i> 저장
			</button>
		</div>
		<!-- 버튼 END -->
	</div>


	<div class="modal-dialog" style="display: none !important;">
		<div class="modal-content">
			<div class="modal-header">
				<h6 class="modal-title" id="myModalLabel">알림</h6>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary">확인</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>

</body>
</html>