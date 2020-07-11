<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=567653f998dff843c90d8a877b592959"></script>
<script type="text/javascript">
$(function () {
	var container = document.getElementById('map');
	var options = {
		center: new kakao.maps.LatLng(37.53708399414581, 127.00667559044228),
		level: 9
	};
	
	var map = new kakao.maps.Map(container, options);
	
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도 타입 컨트롤을 지도에 표시합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    
	    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	    message += '경도는 ' + latlng.getLng() + ' 입니다';
	    console.log(message);
	});
	
	var positions = [
		{title : '신도림역'			, latlng : new daum.maps.LatLng(37.508864214785916	, 126.89118362768451	)},
		{title : '대림역'				, latlng : new daum.maps.LatLng(37.49330722985877	, 126.8949180357134		)},
		{title : '구로디지털단지역'		, latlng : new daum.maps.LatLng(37.48532992214265	, 126.90143624204468	)},
		{title : '신대방역'			, latlng : new daum.maps.LatLng(37.48760531460238	, 126.91337636595776	)},
		{title : '신림역'				, latlng : new daum.maps.LatLng(37.4843094529169	, 126.92969558632633	)},
		{title : '봉천역'				, latlng : new daum.maps.LatLng(37.482522925658195	, 126.94159151483646	)},
		{title : '서울대입구역'			, latlng : new daum.maps.LatLng(37.481284514401565	, 126.9527290263538		)},
		{title : '낙성대역'			, latlng : new daum.maps.LatLng(37.47716168415923	, 126.96341533875173	)},
		{title : '사당역'				, latlng : new daum.maps.LatLng(37.476589275314275	, 126.98163997604883	)},
		{title : '방배역'				, latlng : new daum.maps.LatLng(37.481492167032826	, 126.99754656063803	)},
		{title : '서초역'				, latlng : new daum.maps.LatLng(37.4918535398244	, 127.00763272029951	)},
		{title : '교대역'				, latlng : new daum.maps.LatLng(37.49390722500439	, 127.01423682660402	)},
		{title : '강남역'				, latlng : new daum.maps.LatLng(37.49805843768894	, 127.02786456096284	)},
		{title : '역삼역'				, latlng : new daum.maps.LatLng(37.500705045114344	, 127.03649436331487	)},
		{title : '선릉역'				, latlng : new daum.maps.LatLng(37.504520814619596	, 127.04892551847279	)},
		{title : '삼성역'				, latlng : new daum.maps.LatLng(37.50887499967729	, 127.06302099335264	)},
		{title : '종합운동장역'			, latlng : new daum.maps.LatLng(37.51117534828172	, 127.07376804098645	)},
		{title : '잠실새내역'			, latlng : new daum.maps.LatLng(37.51165354731999	, 127.08609719345888	)},
		{title : '잠실역'				, latlng : new daum.maps.LatLng(37.513318366557215	, 127.10011339458029	)},
		{title : '잠실나루역'			, latlng : new daum.maps.LatLng(37.52073044042866	, 127.10379972479474	)},
		{title : '강변역'				, latlng : new daum.maps.LatLng(37.535262276540024	, 127.094643981518		)},
		{title : '구의역'				, latlng : new daum.maps.LatLng(37.537187967418745	, 127.08606996959442	)},
		{title : '건대입구역'			, latlng : new daum.maps.LatLng(37.54045167948844	, 127.06918032719078	)},
		{title : '성수역'				, latlng : new daum.maps.LatLng(37.544603241026294	, 127.0560466418799		)},
		{title : '뚝섬역'				, latlng : new daum.maps.LatLng(37.54726499244596	, 127.04735787179263	)},
		{title : '한양대역'			, latlng : new daum.maps.LatLng(37.55577185832972	, 127.04361154188986	)},
		{title : '왕십리역'			, latlng : new daum.maps.LatLng(37.561274662109504	, 127.03712941112394	)},
		{title : '상왕십리역'			, latlng : new daum.maps.LatLng(37.564448374100735	, 127.02929278858862	)},
		{title : '신당역'				, latlng : new daum.maps.LatLng(37.56568925669084	, 127.0195646929113		)},
		{title : '동대문역사문화공원역'	, latlng : new daum.maps.LatLng(37.565672514070904	, 127.00900983056624	)},
		{title : '을지로4가역'			, latlng : new daum.maps.LatLng(37.56665942568529	, 126.99767959844787	)},
		{title : '을지로3가역'			, latlng : new daum.maps.LatLng(37.5662941961238	, 126.99092218069744	)},
		{title : '을지로입구역'			, latlng : new daum.maps.LatLng(37.566049932795		, 126.98218964839458	)},
		{title : '시청역'				, latlng : new daum.maps.LatLng(37.563688136011514	, 126.97555752150143	)},
		{title : '충정로역'			, latlng : new daum.maps.LatLng(37.55977049041413	, 126.96447283076228	)},
		{title : '아현역'				, latlng : new daum.maps.LatLng(37.55741609230703	, 126.95615548838506	)},
		{title : '이대역'				, latlng : new daum.maps.LatLng(37.55682191349085	, 126.9464001147048		)},
		{title : '신촌역'				, latlng : new daum.maps.LatLng(37.55520443343217	, 126.93690040185176	)},
		{title : '홍대입구역'			, latlng : new daum.maps.LatLng(37.55688606767447	, 126.92378760070608	)},
		{title : '합정역'				, latlng : new daum.maps.LatLng(37.549973571039715	, 126.91451510521853	)},
		{title : '당산역'				, latlng : new daum.maps.LatLng(37.53483659469544	, 126.90263548739627	)},
		{title : '영등포구청역'			, latlng : new daum.maps.LatLng(37.52585304329085	, 126.89666266162492	)},
		{title : '문래역'				, latlng : new daum.maps.LatLng(37.517972109134014	, 126.89477316993448	)},
	];
	
	var linePath;
	var lineLine = new daum.maps.Polyline();
	var distance;
	
	var poLen = positions.length;
	for (var i = 0; i <= poLen; i++) {
		if (i != 0 && i < poLen) {
			linePath = [positions[i - 1].latlng, positions[i].latlng];
		}
		
		// 시작점과 마지막점 연결
		if (i == poLen) {
			linePath = [positions[i - 1].latlng, positions[0].latlng];
		}
		
		lineLine.setPath(linePath);
		
		var drawLine = new daum.maps.Polyline({
			map 			: map,
			path 			: linePath,
			strokeWeight 	: 5,
			strokeColor		: 'green',
			strokeOpacity	: 1,
			strokeStyle		: 'solid',
		});
		
		distance = Math.round(lineLine.getLength());
	}
	
	function getInfo () {
	    // 지도의 현재 중심좌표를 얻어옵니다 
	    var center = map.getCenter(); 
	    
	    // 지도의 현재 레벨을 얻어옵니다
	    var level = map.getLevel();
	    
	    // 지도타입을 얻어옵니다
	    var mapTypeId = map.getMapTypeId(); 
	    
	    // 지도의 현재 영역을 얻어옵니다 
	    var bounds = map.getBounds();
	    
	    // 영역의 남서쪽 좌표를 얻어옵니다 
	    var swLatLng = bounds.getSouthWest(); 
	    
	    // 영역의 북동쪽 좌표를 얻어옵니다 
	    var neLatLng = bounds.getNorthEast(); 
	    
	    // 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
	    var boundsStr = bounds.toString();
	    
	    
	    var message = '지도 중심좌표는 위도 ' + center.getLat() + ', <br>';
	    message += '경도 ' + center.getLng() + ' 이고 <br>';
	    message += '지도 레벨은 ' + level + ' 입니다 <br> <br>';
	    message += '지도 타입은 ' + mapTypeId + ' 이고 <br> ';
	    message += '지도의 남서쪽 좌표는 ' + swLatLng.getLat() + ', ' + swLatLng.getLng() + ' 이고 <br>';
	    message += '북동쪽 좌표는 ' + neLatLng.getLat() + ', ' + neLatLng.getLng() + ' 입니다';
	    
	    // 개발자도구를 통해 직접 message 내용을 확인해 보세요.
	    // ex) console.log(message);
	}
});
</script>

<div id="map" style="width:100%;height:600px;"></div>