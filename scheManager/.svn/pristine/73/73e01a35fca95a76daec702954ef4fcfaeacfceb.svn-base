<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- fullcalendar -->
<link href="/lib/fullCalendar/fullcalendar.min.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/lib/fullCalendar/moment.min.js"></script>
<script type="text/javascript" src="/lib/fullCalendar/moment_de.min.js"></script>
<script type="text/javascript" src="/lib/fullCalendar/fullcalendar.min.js"></script>
<!-- datepicker -->
<link href="/lib/Dashio/lib/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="/lib/Dashio/lib/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>


<script>

$(function () {
	
	
	// 시간 select box 초기화
	setTimeStamp();
	
	//생성일 start date
	var creStartDate = $('#createStartDate').datepicker({
		format		: 'yyyy-mm-dd',
		onRender	: function(date) {
            return date.valueOf() < now.valueOf() ? 'disabled' : '';
        }
    }).on('changeDate', function(ev) {
        if (ev.date.valueOf() > creEndDate.date.valueOf()) {
            var newDate = new Date(ev.date)
            newDate.setDate(newDate.getDate() + 1);
            checkout.setValue(newDate);
        }
        creStartDate.hide();
        $('#createEndDate')[0].focus();
    }).data('datepicker');
	
	//생성일 end date
    var creEndDate = $('#createEndDate').datepicker({
    	format		: 'yyyy-mm-dd',
    	"setDate"	: new Date(),
        onRender	: function(date) {
            return date.valueOf() <= creStartDate.date.valueOf() ? 'disabled' : '';
        }
    }).on('changeDate', function(ev) {
    	creEndDate.hide();
    }).data('datepicker');
	
	
	// 일정 추가 click event
	/* 
	calendar.on('beforeCreateSchedule', function (e) {
		
		var thisDate = converter.date.basic.toString(e.start._date, '-');
		$('#createStartDate, #createEndDate').val(thisDate);
		
		$('#calendarAddModal').removeClass('fade').show();
		
	}); 
	*/
});

/**
 * 시간, 분 설정
 */
function setTimeStamp () {
	var html = '';
	
	var maxHour = 24;
	for (var i = 1; i <= maxHour; i++) {
		var hour = (i < 10 ? '0' + i : i);
		html += '<option value="' + hour + '">' + hour + '</option>';
	}
	
	$('.date_hour').empty();
	$('.date_hour').append(html);

	html = '';
	
	var maxTime = 60;
	for (var i = 0; i < maxTime; i++) {
		var time = (i < 10 ? '0' + i : i);
		html += '<option value="' + time + '">' + time + '</option>';
	}
	
	$('.date_time').empty();
	$('.date_time').append(html);
}
</script>

<style>
.modal-header{padding-top:5px;padding-bottom:5px;}
.close{color:white;opacity:0.8;}
.form-control{height:25px;padding:6px 6px;}
.date_hour, .date_time{width:45% !important;float:left;}
.date_span{float:left;}
.wrapper {
  margin: 2rem;
}
</style>
<div id="app" class="wrapper">  
	<div id="calendar"></div>
  <!-- <calendar class="fuck" :events="events" :editable="true"></calendar> -->
</div>

<div id="addPopup">

	<div class="modal fade move" id="calendarAddModal" tabindex="-1" role="dialog" aria-labelledby="calendarAddModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:400px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h5 class="modal-title" id="calendarAddTitle">가계 등록</h5>
				</div>
				<div class="modal-body">
					<table class="table">
						<colgroup>
							<col width="20%"/>
							<col width="15%"/>
							<col width="30%"/>
							<col width="35%"/>
						</colgroup>
						<tbody>
							<tr>
								<th rowspan="2" style="vertical-align:middle;">일정 기간</th>
								<th>시작일</th>
								<td>
			                    	<input type="text" class="form-control" id="createStartDate">
								</td>
								<td>
									<select class="form-control date_hour"></select>
									<span class="date_span">&nbsp;:&nbsp;</span>
									<select class="form-control date_time"></select>
								</td>
							</tr>
							<tr>
								<th>종료일</th>
								<td>
			                    	<input type="text" class="form-control" id="createEndDate">
								</td>
								<td>
									<select class="form-control date_hour"></select>
									<span class="date_span">&nbsp;:&nbsp;</span>
									<select class="form-control date_time"></select>
								</td>
							</tr>
							<!-- 
							<tr>
								<th>품목 코드</th>
								<td><input type="text" id="itemCode"/></td>
							</tr>
							<tr>
								<th>품목 유형</th>
								<td>
									<select id="itemType">
										<option value="R">수익</option>
										<option value="E">지출</option>
									</select>
								</td>
							</tr> 
							-->
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sm btn-default" id="codeCloseBtn" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-sm btn-primary" id="codeDeleteBtn"  v-on:click="del()">삭제</button>
					<button type="button" class="btn btn-sm btn-primary" id="codeInsertBtn"  v-on:click="save()">저장</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>


Vue.component('calendar', {
	template	: '<div></div>',
	props		: {
		
	    events : {
	      type		: Array, 
	      required	: true
	    },
	    
	    editable : {
	      type		: Boolean,
	      required	: false,
	      'default'	: false
	    },
	    
	    droppable : {
	      type		: Boolean,
	      required	: false,
	      'default'	: false
	    },
	},
	  
	data		: function () {
    	return {
	    	cal : ''
	    }
	},
	  
	ready		: function () {
	    var self = this;
	    self.cal = $(self.$el);
	    var args = {
	    	lang				: 'de',
	      	height				: "auto",
	      	allDaySlot			: false,
	      	slotEventOverlap	: false,
	      	timeFormat			: 'HH:mm',
	      	events				: self.events,
	      	header				: {
	        	left	: 'prev,next today',
	        	center	: 'title',
	        	right	: 'month,agendaWeek,agendaDay'
	      	},
	      	dayClick			: function (date) {
	            self.$dispatch('day::clicked', date);
	            self.cal.fullCalendar('gotoDate', date.start);
	            self.cal.fullCalendar('changeView', 'agendaDay');
	      	},

	      	eventClick			: function (event) {
		    	    self.$dispatch('event::clicked', event);
		    }
	    }
	    
	    if (self.editable) {
	    	args.editable 		= true;
	      	args.eventResize 	= function (event) {
	        	self.$dispatch('event::resized', event);
	      	}
	      	args.eventDrop 		= function (event) {
	        	self.$dispatch('event::dropped', event);
	      	}
	    }
	    
	    if (self.droppable) {
	   		args.droppable = true;
	      	args.eventReceive = function (event) {
	        	self.$dispatch('event::received', event);
	      	}
	    }
	    
	    this.cal.fullCalendar(args);
	}
	  
});

new Vue({
	el		: '#app',
  	data	: {    
	    events	: [
	        {
	            title	: 'Event1',
	            start	: '2015-10-10 12:30:00',
	          	end		: '2015-10-10 16:30:00'
	        },
	        {
	            title	: 'Event2',
	            start	: '2015-10-07 17:30:00',
	          	end		: '2015-10-07 21:30:00'
	        }
	    ]
	},
  
  	events	: {
    	'day::clicked': function (date) {
      		console.log(date);
    	}
 	}
	
});

</script>