<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
	#sidoList, #gugunList, #dongList {
		width: 32%;
		border: 1px solid #d1d3e2;
	}
	
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
  .count-area {
  	font-size : 11px;
  }
  .row-limit {
 	float			: right;
    width			: 48px;
    padding			: 3px;
    line-height		: 0;
    font-size		: 11px;
    border-radius	: 2px;
    height			: 22px;
  }
</style>

<script> 
var page = 1;
var limit = 10;

$(function () {
	memberRealEstateList();
});

function memberRealEstateList (page) {
	if (!page) {
		page = 1;
	}
	
	$.ajax({
		url 		: '/rest/realEstate/list',
		data 		: {
			page 		: (page * limit - limit),
			limit		: limit,
			
			houseName 			: $('#searchHouseName').val(),
			address				: $('#searchAddress').val(),
			useApproveDateStr	: $('#searchUseApproveDate').val(),
			stationLine			: $('#searchStationLine').val(),
			stationName 		: $('#searchStationName').val(),
		},
		type 		: 'POST',
		dataType 	: 'JSON'
		
	}).done(function (result) {
		
		if (result.status) {
			
			var list 		= result.list;
			var listLength 	= list.length;
			var totalCount	= result.totalCount;
			var endCount 	= 0;
			var html 		= '';
			
			for (var i = 0; i < listLength; i++) {
				var thisData = list[i];
				
				html += '<tr>';
				html += '	<td class="text-tooltip text-right">' + (i + 1) + '</td>';
				html += '	<td class="text-tooltip">' + thisData.houseName + '</td>';
				html += '	<td class="text-tooltip">' + thisData.address + '</td>';
				html += '	<td class="text-tooltip text-center">' + common.date.toString(new Date(thisData.useApproveDate), '-') + '</td>';
				html += '	<td class="text-tooltip">' + thisData.stationLine + '</td>';
				html += '	<td class="text-tooltip">' + thisData.stationName + '</td>';
				html += '	<td class="text-tooltip text-right">' + common.number.addComma(thisData.stationRange) + '</td>';
				html += '	<td class="text-tooltip text-right">' + common.number.addComma(thisData.totalHouseholdCount) + '</td>';
				html += '	<td class="text-tooltip text-right">' + common.number.addComma(thisData.parkingPossibleCount) + '</td>';
				html += '	<td class="text-tooltip text-center">' + thisData.directionType + '</td>';
				html += '	<td class="text-tooltip text-right">' + common.number.addComma(thisData.bay) + '</td>';
				html += '	<td class="text-tooltip text-right">' + thisData.supplySpace + '</td>';
				html += '	<td class="text-tooltip text-right">' + thisData.exclusiveSpace + '</td>';
				html += '</tr>';
			}
			
			if (listLength == 0) {
				html = '<tr><td colspan="13" class="text-center">데이터가 없습니다.</td></tr>';
			}
			
			$('#memberRealEstateTable tbody').empty().append(html);
			
			// paging
			common.paging(page, limit, 10, totalCount, memberRealEstateList);

			// total count
			$('#totalCount').text(totalCount);
		} else {
			alert('서버 에러');
		}
		
	}).fail(function () {
		alert('서버 에러');
	});
}
</script>

<body>
<div class="container-fluid">
	<h4 class="mb-2 text-gray-800">부동산 관리</h4>
	
	<!-- search START -->
	<div class="card shadow mb-4">
    	<div class="card-header py-3">
         	<h6 class="m-0 font-weight-bold text-primary">Search</h6>
       	</div>
       	<div class="card-body">
        	<div class="table-responsive">
          		<table class="table">
          			<colgroup>
						<col width="5%"/>
						<col width="7%"/>
						<col width="5%"/>
						<col width="7%"/>
						<col width="5%"/>
						<col width="7%"/>
						<col width="5%"/>
						<col width="7%"/>
						<col width="7%"/>
						<col width="auto"/>
					</colgroup>
					<tbody>
						<tr>
							<th class="text-right">매물명</th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm datepicker" id="searchHouseName"/>
							</td>
							<th class="text-right">주소</th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm datepicker" id="searchAddress"/>
							</td>
							<th class="text-right">사용승인일</th>
							<td>
								<input type="text" class="form-control form-control-sm datepicker" id="searchUseApproveDate"/>
							</td>
						</tr>
						<tr>
							<th class="text-right">호선</th>
							<td>
								<select class="form-control" id="searchStationLine"></select>
							</td>
							<th class="text-right">이름</th>
							<td>
								<select class="form-control" id="searchStationName"></select>
							</td>
						</tr>
					</tbody>
          		</table>
       		</div>
      	</div>
   	</div>
   	<!-- search END -->
   	
	<!-- list START -->
    <div class="card shadow mb-4">
	    <div class="card-header py-3">
	      	<h6 class="m-0 font-weight-bold text-primary">목록</h6>
	    </div>
    	<div class="card-body">
    		<div>
    			<span class="count-area">총 <span id="totalCount">0</span>건</span>
    			<select class="form-control row-limit">
    				<option value="10">10</option>
    				<option value="25">25</option>
    				<option value="50">50</option>
    				<option value="100">100</option>
    			</select>
    		</div>
          	<div class="table-responsive">
               	<table class="table table-bordered" id="memberRealEstateTable">
               		<colgroup>
						<col width="5%"/>
						<col width="10%"/>
						<col width="auto"/>
						<col width="10%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
						<col width="5%"/>
					</colgroup>
               		<thead>
                   		<tr>
							<th class="text-center" rowspan="2">번호</th>
							<th class="text-center" rowspan="2">매물명</th>
							<th class="text-center" rowspan="2">주소</th>
							<th class="text-center" rowspan="2">사용승인일</th>
							<th class="text-center" colspan="3">역 정보</th>
							<th class="text-center" colspan="4">세대 정보</th>
							<th class="text-center" colspan="2">면적 정보</th>
                   		</tr>
                   		<tr>
							<th class="text-center">호선</th>
							<th class="text-center">이름</th>
							<th class="text-center">거리</th>
							<th class="text-center">세대</th>
							<th class="text-center">주차</th>
							<th class="text-center">방향</th>
							<th class="text-center">Bay</th>
							<th class="text-center">공급</th>
							<th class="text-center">전용</th>
                   		</tr>
                 	</thead>
               		<tbody>
               		</tbody>
              	</table>	
           	</div>
           	<div class="dataTables_paginate paging_simple_numbers float-right">
				<ul id="pagination" class="pagination">
				</ul>
			</div>
       	</div>
    </div> 
    <!-- list END -->
</div>
</body>