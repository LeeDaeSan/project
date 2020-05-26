<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=7f74108c9e96ea9b3c3dadb724bc5300&libraries=services"></script>
	<script type="text/javascript">
	
	$(function () {
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};
	
		var map = new kakao.maps.Map(container, options); //지도 생
		
		// 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정합니다 
		var points = [
		    new kakao.maps.LatLng(33.452278, 126.567803),
		    new kakao.maps.LatLng(33.452671, 126.574792),
		    new kakao.maps.LatLng(33.451744, 126.572441)
		];

		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
		var bounds = new kakao.maps.LatLngBounds();    

		var i, marker;
		for (i = 0; i < points.length; i++) {
		    // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
		    marker =     new kakao.maps.Marker({ position : points[i] });
		    marker.setMap(map);
		    
		    // LatLngBounds 객체에 좌표를 추가합니다
		    bounds.extend(points[i]);
		}
		
		var geocoder = new kakao.maps.services.Geocoder();

		// click event
		kakao.maps.event.addListener(map, 'click', function(e) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = e.latLng;
		    
		    geocoder.coord2RegionCode(latlng.getLng(), latlng.getLat(), function(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
					console.log(result);
			        console.log('지역 명칭 : ' + result[0].address_name);
			        console.log('행정구역 코드 : ' + result[0].code);
			    }
			});
		});
	});
	
	</script>
</head>
<body>

	<div id="map" style="width:100%;height:550px;"></div>
</body>
</html>