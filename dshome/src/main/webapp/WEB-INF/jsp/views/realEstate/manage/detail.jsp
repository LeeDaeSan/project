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
		
		var param = {
			
			houseName			 : $.trim($("#complexName").val()),						// 매물명
			address				 : $.trim($("#address").val()),							// 매물 주소
			stationLine			 : $("#stationLine").val(),								// 지하철 호선
			stationName			 : $.trim($("#station").val()),							// 지하철 명
			stationRange		 : $.trim($("#stationRange").val()),					// 매물과 지하철과의 거리
			useApproveDateStr	 : $.trim($("#useApproveDate").val()),					// 사용승인일
			totalHouseholdCount	 : $.trim($("#totalHouseholdCount").val()),				// 총 세대 수
			parkingPossibleCount : $.trim($("#parkingPossibleCount").val()),			// 총 주차 대수
			directionType		 : $("#directionType :selected").val(),					// 방향(거실기준)
			bay					 : $.trim($("#bay").val()),								// Bay
			supplySpace			 : $.trim($("#supplySpace").val()),						// 공용면적
			exclusiveSpace		 : $.trim($("#exclusiveSpace").val()),					// 전용면적
			dealType			 : $("#dealType :selected").val(),						// 거래타입
			dealPrice			 : $.trim($("#dealPrice").val()),						// 거래가격
			brokerFee			 : $.trim($("#brokerFee").val()),						// 중개보수
			acquisitionTax		 : $.trim($("#acquisitionTax").val()),					// 취득세
			propertyTotalTax	 : $.trim($("#propertyTotalTax").val()),				// 보유세
			remark				 : $("#remark").val(),									// 비고
			type				 : "I"
				
		}
		
		console.log(param);
		$.post("/realEstate/merge", param, function(result){
			console.log(result);
		});
		
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
	
});
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
										<option value="SM1">1호선</option>
										<option value="SM2">2호선</option>
										<option value="SM3">3호선</option>
										<option value="SM4">4호선</option>
										<option value="SM5">5호선</option>
										<option value="SM6">6호선</option>
										<option value="SM7">7호선</option>
										<option value="SM8">8호선</option>
										<option value="SM9">9호선</option>
										<option value="IM1">인천1호선</option>
										<option value="IM2">인천2호선</option>
										<option value="KR1">경의중앙선</option>
										<option value="KR2">수인분당선</option>
										<option value="KR3">경강선</option>
										<option value="KR4">경춘선</option>
										<option value="SBS">신분당선</option>
										<option value="GGG">김포골드</option>
										<option value="SWSH">서해선</option>
									</select>
								</div>
								<div class="col-md-4">
									<input class="form-control" id="station" style="">
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
										<!-- directionTypeCode -->
										<option value="SS">남향</option>
										<option value="ES">남동향</option>
										<option value="WS">남서향</option>
										<option value="NS">남북향</option>
										<option value="EE">동향</option>
										<option value="WW">서향</option>
										<option value="NN">북향</option>
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
										<!-- directionTypeCode -->
										<option value="A1">매매</option>
										<option value="B1">전세</option>
										<option value="B2">월세</option>
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
			<button type="button" class="d-none d-sm-inline-block btn btn-primary shadow-sm" id="save">
				<i class="fas fa fa-check fa-sm text-white-50"></i> 저장
			</button>
		</div>
		<!-- 버튼 END -->
	</div>
	
</body>
</html>