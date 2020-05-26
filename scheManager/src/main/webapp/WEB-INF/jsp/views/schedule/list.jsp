<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/lib/ToastUI/calendar/tui-code-snippet.js"></script>
<script type="text/javascript" src="/lib/ToastUI/calendar/tui-calendar.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/ToastUI/calendar/tui-calendar.css">

<script>

var calendar;
var dataList;

$(function () {
	
	/*==================================================*/
	/* 	캘린더 생성 순서
	/*
	/* 	1. 일정 초기 옵션 설정 및 생성
	/*
	/*	2. 데이터 바인딩
	/*    2-1. 데이터 리스트를 불러와 바인딩
	/*    2-2. 각 데이터의 옵션설정
	    
	/* 	3. 이벤트 생성
	/*    3-1. 등록, 상세, 수정, 삭제
	/*    3-2. 오늘, 이전, 이후 호출 이벤트
	/*
	
		* 일정 색상 정책 (배경, 폰트)
	
		Table 	: CalendarColor
		columns	: 
			1. ColorIdx PK
			2. ColorCode 색상 코드
			3. ColorName 색상 이름
			
			#ffffff		// 흰색
			#ff4040		// 빨강
			#bbdc00		// 연두
			#9d9d9d		// 회색
			#9e5fff		// 보라
			#00a9ff		// 하늘
			#ffbb3b		// 주황
			#03bd9e		// 초록
			#ff5583		// 분홍

	/*==================================================*/
	
	// 일정 초기 옵션 설정 및 생성 
	calendar = new tui.Calendar('#calendar', {
		defaultView			: 'month',
// 		useCreationPopup	: true,
// 	  	useDetailPopup		: true,
		month				: {
			daynames		: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			startDayOfWeek 	: 0,
		},
	});
	
	dataList = [
		{
			id 				: '1',
			calendarId 		: 'id_01',
			title			: 'title1',
			category		: 'time',
			dueDateClass 	: '',
			start			: '2019-06-11T09:00:00+09:00',
			end				: '2019-06-12T09:00:00+09:00',
			isReadOnly		: false,
			
			// 일정 색상을 직접 지정할 수 있음
	//			color			: '#ffffff', 
	//		    bgColor			: '#9e5fff',
	//		    dragBgColor		: '#9e5fff',
	//		    borderColor		: '#9e5fff'
		}  
	];	
	
	// 일정 배열 추가
	calendar.createSchedules(dataList);
	
	
	// calendar Id 별 색상 지정
	calendar.setCalendarColor('id_01', {
		color		: '#ffffff',
		bgColor		: '#ff5583',
		dragBgColor	: '#ff5583',
		borderColor	: '#ff5583'
	});
	
	// Today event
	$('#todayBtn').unbind('click').click(function () {
		calendar.today();	
	});
	
	// PREV event
	$('#prevBtn').unbind('click').click(function () {
		calendar.prev();
	});

	// Next event
	$('#nextBtn').unbind('click').click(function () {
		calendar.next();	
	});
	
	// 상세 팝업
	calendar.on('clickSchedule', function (e) {
		reloadCalendar();
	});
	
	// 신규 팝업
	calendar.on('beforeCreateSchedule', function (e) {
		$('#popup').show();
	});
	
	// 기간 변경 (일 / 주 / 월)
	$('.period_btn').unbind('click').click(function () {
		calendar.changeView($(this).attr('periodType'), true);
	});
});

/**
 *	캘린더 리로드 
 *
 */
function reloadCalendar () {
	
 	calendar.clear();					
   	calendar.createSchedules(dataList);
    calendar.render();	
		
}
</script>
<h2>일정 관리</h2>

<!-- 달력 페이징 START -->
<div id="menu">
	<span id="menu-navi">
    	<button type="button" class="btn btn-default btn-sm move-today" data-action="move-today" id="todayBtn">Today</button>
    	<button type="button" class="btn btn-default btn-sm move-day" data-action="move-prev" id="prevBtn">
    		PREV
    	</button>
	    <button type="button" class="btn btn-default btn-sm move-day" data-action="move-next" id="nextBtn">
	    	NEXT
	    </button>
  	</span>
  	<span id="renderRange" class="render-range"></span>
</div>
<!-- 달력 페이징 END -->

<!-- 기간 유형 START -->
<div>
	<button type="button" class="period_btn" periodType="day">DAY</button>
	<button type="button" class="period_btn" periodType="week">WEEK</button>
	<button type="button" class="period_btn" periodType="month">MONTH</button>
</div>
<!-- 기간 유형 END -->

<div id="calendar" style="height: 600px;overflow:auto;"></div>

<div id="popup" style="display:none;">
	<div>
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text"/></td>
			</tr>
		</table>
	</div>
	<div>
		<button>등록</button>
	</div>
</div>
