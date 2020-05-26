
/**
 * 캘린더 공통 함수
 * 
 */
var Calendar = {
	options : {},
	
	init : function (tagId, options) {
		
		Calendar.options = options;
		
		// date 관련 변수
		var day = options.toDay ? options.toDay : new Date();
		
		// 캘린더 레이아웃 분할
		Calendar.makeLayout(tagId);
		
		// 헤더영역 버튼 생성
		//Calendar.makeHeaderButtons(tagId, options, day);
		
		// 바디영역 캘린더 생성
		Calendar.makeBodyCalendar(tagId, options, day);
		
		// click event
		//Calendar.dateOfClickListener(tagId);

		return Calendar;
	},
	
	/**
	 * 캘린더의 layout 분할 생성
	 */
	makeLayout : function (tagId) {
		
		tagId.empty().append('<div class="calendar-body-wrap"></div>');
	},
	
	/**
	 * 헤더 영역의 버튼 생성
	 */
	makeHeaderButtons : function (tagId, options, day) {
		
		var year 	= day.getFullYear();
		var month 	= day.getMonth();
		
		// header buttons
		var html  = '<div class="header-full-wrap">';
			// 1. prev button
			html += '	<span><button class="calendar-shift-btn" type="M" year="' + year + '" month="' + month + '"><</button></span>';
			// 2. center button
			html += '	<span class="header-year">' + year + '년</span>';
			html += '	<span class="header-month">' + (month + 1) + '월</span>';
			// 3. next button
			html += '	<span><button class="calendar-shift-btn" type="P">></button></span>';
			html += '</div>';
			
		tagId.find('.calendar-header-wrap').empty().append(html);
	},
	
	/**
	 * 바디 영역의 캘린더 생성
	 */
	makeBodyCalendar : function (tagId, options, day) {
		// date 관련 변수
		var today		= new Date();
		var year 		= day.getFullYear();
		var month 		= day.getMonth();
		var first 		= new Date(year, month, 1);
		var last 		= new Date(year, (month + 1), 0);
		var firstToInt 	= parseInt(dateToString(first, ''));
		var lastToInt  	= parseInt(dateToString(last, ''));
		
		var html  = '<table class="table calendar-table-layout">';
		
		// 요일 헤더 생성
		html = Calendar.makeWeekHeader(options.week, html);
			
		// 날짜 생성
		html += '	<tbody>';
		
		// date loop
		var dateCnt = 0;
		for (var i = firstToInt; i <= lastToInt; i++) {
			var numToStr	= i.toString();
			var initDate 	= new Date(numToStr.substring(0, 4), (numToStr.substring(4, 6) - 1), numToStr.substring(6));
			var initDay 	= initDate.getDay();
			
			// date count가 0 이거나, 요일이 일요일인 경우
			if (dateCnt == 0 || initDay == 0) {
				html += '<tr>';
			}
		
			// 나머지 td가 있는 경우
			if (dateCnt == 0 && initDay > 0) {
				html = Calendar.makeRestTd(initDay, html);
			}
			
			var dateText = (dateCnt + 1);
			
			// 날짜 생성
			html += '<td ' + (options.buttonAttr ? options.buttonAttr : '') + ' thisDate="' + dateToString(initDate, '-') + '" class="day_click day_hover ';
			// today
			if (day.getMonth() == new Date().getMonth() && today.getDate() == (dateCnt + 1)) {
				html += 	'today_selected ';
			}
			
			html += 	(initDay == 0 ? 'red' : '');		// 일요일 / 공휴일 color 지정
			html += 	(initDay == 6 ? 'blue' : '');		// 토요일 color 지정
			
			html += '">';
			html += '	<div class="day-div-class">';
			html += '	<div class="day-div-number">' + dateText + '</div>';
			html += '	<div class="day_text day_' + dateText + '"></div>';
			html += '	</div>';
			html += '</td>';
			
			// 토요일인 경우 줄바꿈
			if (((initDay + 1) % 7 == 0)) {
				html += '</tr>';
			}
			
			// 마지막 날짜의 요일과 date count가 같은 경우 줄바꿈
			var lastDate = lastToInt.toString().substring(6, 8);
			if (((lastDate - 1) == dateCnt)) {
				
				// 나머지 td가 있는 경우
				html = Calendar.makeRestTd((6 - initDay), html);
				
				html += '</tr>';
			}
			
			dateCnt++;
		}
			
		html += '	</tbody>';
		html += '</table>';
			
		tagId.find('.calendar-body-wrap').empty().append(html);
	},
	
	/**
	 * 나머지 td 생성
	 */
	makeRestTd : function (restCnt, html) {
		for (var i = 0; i < restCnt; i++) {
			html += '<td></td>';
		}
		
		return html;
	},
	
	/**
	 * 요일 헤더 생성
	 */
	makeWeekHeader : function (weekArr, html) {
		
		if (!weekArr || weekArr.length != 7) {
			weekArr = ['일', '월', '화', '수', '목', '금', '토'];
		}
		
		var weekLength = weekArr.length;
		
		html += '<thead>';
		html += '	<tr>';
		
		// 요일 생성
		for (var i = 0; i < weekLength; i++) {
			html += '<th class="';
			html += 	(i == 0 ? 'red' : '');		// 일요일 / 공휴일 color 지정
			html += 	(i == 6 ? 'blue' : '');		// 토요일 color 지정
			html += '">' + weekArr[i] + '</th>';
		}
		
		html += '	</tr>';
		html += '</thead>';
		
		return html;
	},
	
	/**
	 * 날짜 click event
	 */
	dateOfClickListener : function () {
		
		$('.day_click').unbind('click').click(function (e) {
			// 이벤트 전파 막기
			e.preventDefault();
			
			if ($(this).hasClass('selected')) {
				$(this).removeClass('selected')
					   .addClass('day_hover');
				
			} else {
				$(this).addClass('selected')
					   .removeClass('day_hover');
			}
		});
	},
	
	/**
	 * 월 변경 function
	 * - type P : plus, M : minus
	 */
	monthCalcuration : function (year, month, type) {
		
		// minus
		if (type == 'M') {
			
			// month가 0이거나 작은 경우 11로 변경, year -1 차감
			if (month <= 0) {
				year--;
				month = 11;	
				
			// 아니면 month만 차감
			} else {
				month--;
			}
			
		// plus
		} else if (type == 'P') {
			
			// month가 11이거나 큰 경우 0으로 변경, year +1 추가
			if (month >= 11) {
				year++;
				month = 0;
				
			// 아니면 month만 추가
			} else {
				month++;
			}
		}

		return new Date(year, month, 1);
	},

};

