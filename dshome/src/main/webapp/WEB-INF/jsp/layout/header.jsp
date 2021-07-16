<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#checkMemoModal .modal-dialog {
	max-width 		: none !important;
	width 			: 1050px !important;
}
#checkMemoModal #checkMemoAddBtn {
	width 			: 100%;
}
#checkMemoModal .check_memo_btn_area {
	padding-bottom 	: 10px;
	float			: right;
}
#checkMemoModal .check_memo_amount_area {
	float			: left;
    font-size		: 12px;
    padding-top		: 18px;
}
.check-memo-checked {
	text-decoration : line-through;
	color			: #c5c5c5 !important;
}
#todayTimeArea {
	margin-top 	: 38px;
}
#todayArea {
	padding-left : 240px;
}
#todayDiv, #befdayDiv {
	margin-top 	: 18px;
	float		: left;
}
#todayDiv span, #befdayDiv span {
	font-size	: 12px;
    padding-left: 10px;
    color		: #818182;
}
#todayDiv ul, #befdayDiv ul {
	height		: 27px;
	overflow 	: hidden;
	margin		: 0;
	padding		: 0;
	list-style	: none;
	font-size	: 13px;
	color		: black;
}
#todayDiv ul li, #befdayDiv ul li {
	height		: 30px;
	padding		: 5px;
	margin		: 0px 5px;
}
</style>
<script type="text/javascript">
var bkList;
var bkListLength = 0;

$(function () {
	
});
</script>
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
	<ul class="navbar-nav ml-auto">
		<li class="nav-item dropdown no-arrow">
	      	<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	        	<span class="mr-2 d-none d-lg-inline text-gray-600 small">Valerie Luna</span>
	      	</a>
	      	<!-- Dropdown - User Information -->
	      	<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
	        	<a class="dropdown-item" href="#">
	          		<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
	          		Profile
	          	</a>
	        	<a class="dropdown-item" href="javascript:void(0);" id="checkMemoPopupBtn" data-toggle="modal" data-target="#checkMemoModal">
	          		<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
	          		Check List
	          	</a>
	        	<div class="dropdown-divider"></div>
	        	<a class="dropdown-item" href="/logout">
	          		<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
	          		Logout
	        	</a>
	      	</div>
	    </li>
	</ul>
</nav>

<!-- Check List Popup START -->
<div class="modal fade" id="checkMemoModal" tabindex="-1" role="dialog" aria-labelledby="myCheckMemoModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myCheckMemoModalLabel"><span id="checkMemoPopupTitle"></span> Check List</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="check_memo_amount_area">
					총 금액 : <span id="checkMemoTotalAmount" class="color-red">0</span>
				</div>
				<div class="check_memo_btn_area">
					<button type="button" class="btn btn-sm btn-warning">초기화</button>
					<button type="button" class="btn btn-sm btn-primary" id="allSaveBtn">일괄저장</button>
				</div>
				<div class="table-responsive">
					<table class="table" id="checkMemoTable">
						<colgroup>
							<col width="5%"/>
							<col width="10%"/>
							<col width="15%"/>
							<col width="10%"/>
							<col width="12%"/>
							<col width="10%"/>
							<col width="7%"/>
							<col width="auto"/>
							<col width="7%"/>
							<col width="7%"/>
						</colgroup>
						<thead>
							<tr>
								<th class="text-center"></th>
								<th class="text-center">은행</th>
								<th class="text-center">계좌번호</th>
								<th class="text-center">예금주</th>
								<th class="text-center">금액</th>
								<th class="text-center">이체유형</th>
								<th class="text-center">이체일</th>
								<th class="text-center">내용</th>
								<th class="text-center">수정</th>
								<th class="text-center">삭제</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
						<tfoot>
							<tr>
								<td class="text-center" colspan="10"><button type="button" class="btn btn-primary" id="checkMemoAddBtn">+</button></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Check List Popup END -->