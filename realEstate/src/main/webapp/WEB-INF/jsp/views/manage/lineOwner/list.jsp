<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=567653f998dff843c90d8a877b592959"></script>

<style>
.table {
	table-layout	: fixed;
}

#rightMenu {
	padding 		: 5px;
	top 			: 55px;
	right 			: -300px;
	width			: 300px;
    height			: 100%;
    background		: #ffffff;
    position		: absolute;
    z-index			: 9999;
    border-left		: 1px solid #d4d4d4;
    border-bottom	: 1px solid #d4d4d4;
    border-top 		: 1px solid #d4d4d4;
    border-radius	: 3px 0px 0px 3px;
    box-shadow		: 1px 1px 0px 0px #eaeaea;
}
#leftBtn {
	margin-top		: 65px;
    float			: left;
    margin-left		: -40px;
    width			: 35px;
    height			: 60px;
    border			: 1px solid #d4d4d4;
    border-radius	: 5px 0px 0px 5px;
    text-align		: center;
    line-height		: 48px;
    color			: #8c8c8c;
    border-right 	: 0;
    z-index			: 99999;
    background		: #ffffff;
    cursor			: pointer;
    box-shadow		: 0px 1px 1px 0px #eaeaea;
}
.line-form {
	margin-top		: 10px;
}
.line-form table {
	border			: 1px solid #dddddd;
}
#lineSaveBtn {
	margin-top		: -35px;
}
#lineOwnerTable {
	border			: 1px solid #dddddd;
}
</style>
<script type="text/javascript">
var map;

$(function () {
	
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(37.53708399414581, 127.00667559044228),
		level: 9
	};
	
	map = new kakao.maps.Map(container, options);
	
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도 타입 컨트롤을 지도에 표시합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    
	    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	    message += '경도는 ' + latlng.getLng() + ' 입니다';
	  
	    if ($('#leftBtn').attr('show') == 'on') {
		    $('#ownerLat').val(latlng.getLat());
		    $('#ownerLng').val(latlng.getLng());
	    }
	    
	});
	
	// left menu event function
	leftMenuFunction();
});

function leftMenuFunction () {
	
	// 라인 유형 목록 조회
	lineKindsList();
	// 라인 정보 목록 조회
	lineOwnerList();
	
	// left check list menu click event
	$('#leftBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		if ($(this).attr('show') == 'off') {
			$(this).attr('show', 'on');
			$(this).html('&gt;');
			
			$('#rightMenu').animate({
				'right' 	: '0',
				'display' 	: 'block'
			});
		} else {
			
			$(this).attr('show', 'off');
			$(this).html('&lt;');
			
			$('#rightMenu').animate({
				'right' 	: '-300px',
				'display' 	: 'none'
			});
		}
	});
	
	// 라인 저장
	$('#lineSaveBtn').unbind('click').click(function (e) {
		e.preventDefault();
		
		if (confirm('라인정보를 저장하시겠습니까?')) {
			
			$.ajax({
				url 		: '/rest/lineOwner/merge',
				method		: 'POST',
				dataType	: 'JSON',
				data		: {
					type			: 'I',
					lineKindsIdx 	: $('#lineKindsSelect').val(),
					ownerName		: $('#ownerName').val(),
					ownerLat		: $('#ownerLat').val(),
					ownerLng		: $('#ownerLng').val()
				},
				success 	: function (result) {
					if (result.status) {
						console.log(result);
						
						lineOwnerList();
						alert('등록 완료');
						
					} else {
						alert('서버 에러');
					}
				}
			});
		}
		
	});
}

/**
 * 라인 정보 목록 조회 Function
 */
function lineOwnerList () {
	$.ajax({
		url 		: '/rest/lineOwner/list',
		method 		: 'POST',
		dataType	: 'JSON',
		data		: {},
		success		: function (result) {
			if (result.status) {
				
				var markerImage = new kakao.maps.MarkerImage(
					'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png',
					new kakao.maps.Size(24, 35)
				);
				
				var html = '';
				var list = result.list;
				var listLength = list.length;
				for (var i = 0; i < listLength; i++) {
					var thisData = list[i];
					
					html += '<tr>';
					html += '	<td>' + (i + 1) + '</td>';
					html += '	<td class="text-tooltip">' + thisData.ownerName + '</td>';
					html += '	<td class="text-tooltip">' + thisData.ownerLat + '</td>';
					html += '	<td class="text-tooltip">' + thisData.ownerLng + '</td>';
					html += '</tr>';
					
					var marker = new kakao.maps.Marker({
						map 		: map,
						position 	: new kakao.maps.LatLng(thisData.ownerLat, thisData.ownerLng),
						title		: thisData.ownerName,
						image 		: markerImage
					});
				}
				
				// 목록 append
				$('#lineOwnerTable tbody').empty().append(html);
				
			} else {
				alert('서버 에러');
			}
		}
	});
}
/*
 * 라인유형 목록 조회 Function 
 */
function lineKindsList () {
	
	$.ajax({
		url 		: '/rest/lineKinds/list',
		method 		: 'POST',
		dataType	: 'JSON',
		data 		: {},
		success		: function (result) {
			if (result.status) {
				
				var html = '';
				var list = result.list;
				var listLength = list.length;
				for (var i = 0; i < listLength; i++) {
					var thisData = list[i];
					
					html += '<option value="' + thisData.lineKindsIdx + '">';
					html +=		thisData.lineKindsName;
					html += '</option>';
				}
				$('#lineKindsSelect').empty().append(html);
				
			} else {
				alert('서버 에러');
			}
		}
	});
}
</script>

<h3>좌표 관리</h3>
<div id="map" style="width:100%;height:600px;"></div>

<!-- 좌표 등록 메뉴 -->
<div id="rightMenu">

	<!-- 좌측 open / close 버튼 -->
	<div id="leftBtn" show="off">&lt;</div>
	
	<!-- 상단 메뉴 탭 -->
	<div class="col-md-12">
		<ul class="nav nav-tabs header_tabs">
		  	<li role="presentation" class="active"><a href="#">라인</a></li>
		  	<li role="presentation"><a href="#">지점</a></li>
		</ul>
		
		<button type="button" class="btn btn-default btn-sm float-right" id="lineSaveBtn">저장</button>
	</div>
	
	<!-- 등록 form -->
	<div class="col-md-12 line-form">
		<table class="table">
			<tr>
				<th>라인유형</th>
				<td>
					<select id="lineKindsSelect" class="form-control">
					</select>
				</td>
			</tr>
			<tr>
				<th>라인 명</th>
				<td>
					<input type="text" id="ownerName" class="form-control"/>
				</td>
			</tr>
			<tr>
				<th>위도</th>
				<td>
					<input type="text" id="ownerLat" class="form-control"/>
				</td>
			</tr>
			<tr>
				<th>경도</th>
				<td>
					<input type="text" id="ownerLng" class="form-control"/>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 목록 조회 -->
	<div class="col-md-12">
		<table class="table" id="lineOwnerTable">
			<thead>
				<tr>
					<th>No.</th>
					<th>명칭</th>
					<th>위도</th>
					<th>경도</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="4" class="text-center">데이터가 없습니다.</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>