<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../../../../lib/sbadmin2/css/all.min.css" />
	<link rel="stylesheet" href="../../../../lib/sbadmin2/css/sb-admin-2.min.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<script src="/webjars/jquery/3.3.1/dist/jquery.min.js"></script>
</head>

<script>
$(function(){
	
	$("#save").unbind("click").click(function(){
		fn_save("I");
	});
	
	$("#update").unbind("click").click(function(){
		fn_save("U");
	})
	
	$("#delete").unbind("click").click(function(){
		fn_save("D");
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
		
		var brokerFee		 = parseInt($("#brokerFee").val() || 0 );
		var acquisitionTax	 = parseInt($("#acquisitionTax").val() || 0);
		var propertyTotalTax = parseInt($("#propertyTotalTax").val() || 0);

		var totalTax = brokerFee + acquisitionTax + propertyTotalTax;

		$("#totalPrice").val(totalTax);
		
	});
	
	// 공통코드 조회 [directionType] : 방향(거실기준)
	fn_retrieveCommCode("direction","directionType");
	
	// 공통코드 조회 [dealType] : 거래타입
	fn_retrieveCommCode("deal","dealType");
	
});

/**
 * @description 공통코드 조회
 * @param		{String} type
 * @param		{String} compId
 * return		N/A
 */
function fn_retrieveCommCode(type, compId){

	$.ajax({
		
		url		 	: "/comm/code/list/" + type,
		type	 	: "GET",
		dataType 	: "JSON",
		data		: {type : type},
		async	 	: false
		
	}).done(function(result){

		if ( result.status ){

			var html = "";
			var list = result.list;
			var listLength = list.length;
			
			html += "<option>" + (listLength === 0 ? '선택없음' : '선택') + "</option>";
			
			if ( listLength != 0 ){
				for (var i in result.list){
					html += "<option value='" + list[i].code + "'>" + list[i].name + "</option>";
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
function fn_save(type){
	
	var param = {
		
		houseName			: $.trim($("#complexName").val()),					// 매물명
		address				: $.trim($("#address").val()),						// 매물 주소
		stationLine			: $("#stationLine").val(),							// 지하철 호선
		stationName			: $.trim($("#stationName").val()),					// 지하철 명
		stationRange		: $.trim($("#stationRange").val()),					// 매물과 지하철과의 거리
		useApproveDateStr	: $.trim($("#useApproveDate").val()),				// 사용승인일
		totalHouseholdCount	: $.trim($("#totalHouseholdCount").val()),			// 총 세대 수
		parkingPossibleCount: $.trim($("#parkingPossibleCount").val()),			// 총 주차 대수
		directionType		: $("#directionType :selected").val(),				// 방향(거실기준)
		bay					: $.trim($("#bay").val()),							// Bay
		supplySpace			: $.trim($("#supplySpace").val()),					// 공용면적
		exclusiveSpace		: $.trim($("#exclusiveSpace").val()),				// 전용면적
		dealType			: $("#dealType :selected").val(),					// 거래타입
		dealPrice			: $.trim($("#dealPrice").val()),					// 거래가격
		brokerFee			: $.trim($("#brokerFee").val()),					// 중개보수
		acquisitionTax		: $.trim($("#acquisitionTax").val()),				// 취득세
		propertyTotalTax	: $.trim($("#propertyTotalTax").val()),				// 보유세
		remark				: $("#remark").val(),								// 비고
		type				: type												// 타입(I:등록/U:수정/D:삭제)
			
	}
	
	var resultType = "";
	
	if ( type == "I" ){
		resultType = "등록";
	} else if ( type == "U" ){
		resultType = "수정";
	} else if ( type == "D" ) {
		resultType = "삭제";
	}
	
	if (confirm(resultType + " 하시겠습니까?")){
		
		$.post("/rest/realEstate/merge", param, function(result){
		
			if (result.status) {
				
				alert(resultType + " 되었습니다.");
				location.reload();
				
			} else {
				alert("서버 에러");
				return false;
			}
		
		});
	
	}
	
}
</script>
<body>

	<div id="default" style="margin: 20px">
	
		<!-- 기본 정보 START -->
		<div class="card mb-4">
			<div class="card-header">기본 정보</div>
			<div class="card-body">
				<div class="sbp-preview">
					<div class="bd-example">
						<form class="">
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="complexName">아파트명</label>
								<div class="col-sm-10">
									<input class="form-control" id="complexName">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="address">주소지</label>
								<div class="col-sm-10">
									<input class="form-control" id="address">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="station">지하철역</label>
								<div class="col-md-2">
									<select class="form-control" id="stationLine">
										<option value="k0304">분당선</option>
									</select>
								</div>
								<div class="col-md-4">
									<select class="form-control" id="stationName">
										<option value="241">망포역</option>
									</select>
								</div>
								<div class="col-md-4">
									<input class="form-control" id="stationRange" placeholder="거리(m)">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="useApproveDate">사용승인일</label>
								<div class="col-sm-10">
									<input class="form-control" id="useApproveDate" placeholder="YYYYMMDD">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="totalHouseholdCount">총 세대/주차</label>
								<div class="col-sm-4">
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
								<div class="col-sm-2">
									<input type="text" class="form-control" id="bay" placeholder="Bay"/>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="space">면적</label>
								<div class="input-group col-sm-5">
									<input type="text" class="form-control" placeholder="공용면적(m2)" id="supplySpace">
									<div class="input-group-append">
										<span class="input-group-text" id="supplySpaceChange"><span></span> 평 <i class="fas fa fa-refresh fa-sm"></i></span>
									</div>
								</div>
								<div class="input-group col-sm-5">
									<input type="text" class="form-control" placeholder="전용면적(m2)" id="exclusiveSpace">
									<div class="input-group-append">
										<span class="input-group-text" id="exclusiveSpaceChange"><span></span> 평 <i class="fas fa fa-refresh fa-sm"></i></span>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="dealType">거래가격</label>
								<div class="col-md-2">
									<select class="form-control" id="dealType">
									</select>
								</div>
								<div class="col-md-3">
									<input class="form-control" id="dealPrice" placeholder="(억)">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="articleTax">세금정보</label>
								<div class="col-sm-3">
									<input class="form-control" id="brokerFee" placeholder="중개보수(VAT 별도)">
								</div>
								<div class="col-sm-3">
									<input class="form-control" id="acquisitionTax" placeholder="취득세">
								</div>
								<div class="col-sm-3">
									<input class="form-control" id="propertyTotalTax" placeholder="보유세">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="totalPrice">총 금액</label>
								<div class="col-sm-10">
									<input class="form-control" id="totalPrice" placeholder="거래가+중개보수+취득세+보유세" readonly>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="remark">비고</label>
								<div class="col-sm-10">
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
				<i class="fas fa fa fa-close fa-sm text-white-50"></i> 취소
			</button>
			<button type="button" class="d-none d-sm-inline-block btn btn-warning shadow-sm" id="update">
				<i class="fas fa fa-check fa-sm text-white-50"></i> 수정
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