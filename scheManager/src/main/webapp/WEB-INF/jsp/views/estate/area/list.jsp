<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=7f74108c9e96ea9b3c3dadb724bc5300&libraries=services"></script>
	<script type="text/javascript">
	
	$(function () {
		var container = document.getElementById('map'); //������ ���� ������ DOM ���۷���
		var options = { //������ ������ �� �ʿ��� �⺻ �ɼ�
			center: new kakao.maps.LatLng(33.450701, 126.570667), //������ �߽���ǥ.
			level: 3 //������ ����(Ȯ��, ��� ����)
		};
	
		var map = new kakao.maps.Map(container, options); //���� ��
		
		// ��ư�� Ŭ���ϸ� �Ʒ� �迭�� ��ǥ���� ��� ���̰� ���� ������ �缳���մϴ� 
		var points = [
		    new kakao.maps.LatLng(33.452278, 126.567803),
		    new kakao.maps.LatLng(33.452671, 126.574792),
		    new kakao.maps.LatLng(33.451744, 126.572441)
		];

		// ������ �缳���� ���������� ������ ���� LatLngBounds ��ü�� �����մϴ�
		var bounds = new kakao.maps.LatLngBounds();    

		var i, marker;
		for (i = 0; i < points.length; i++) {
		    // �迭�� ��ǥ���� �� ���̰� ��Ŀ�� ������ �߰��մϴ�
		    marker =     new kakao.maps.Marker({ position : points[i] });
		    marker.setMap(map);
		    
		    // LatLngBounds ��ü�� ��ǥ�� �߰��մϴ�
		    bounds.extend(points[i]);
		}
		
		var geocoder = new kakao.maps.services.Geocoder();

		// click event
		kakao.maps.event.addListener(map, 'click', function(e) {        
		    
		    // Ŭ���� ����, �浵 ������ �����ɴϴ� 
		    var latlng = e.latLng;
		    
		    geocoder.coord2RegionCode(latlng.getLng(), latlng.getLat(), function(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
					console.log(result);
			        console.log('���� ��Ī : ' + result[0].address_name);
			        console.log('�������� �ڵ� : ' + result[0].code);
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