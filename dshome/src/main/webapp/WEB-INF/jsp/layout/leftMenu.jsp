<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#checkMemoDiv{
	padding			: 5px;
	top 			: 55px;
	left 			: -302px;
	width			: 300px;
    height			: 100%;
    background		: #ffffff;
    position		: absolute;
    z-index			: 9999;
    border-right	: 1px solid #d4d4d4;
    border-bottom	: 1px solid #d4d4d4;
    border-top 		: 1px solid #d4d4d4;
    border-radius	: 0px 3px 3px 0px;
    box-shadow		: 1px 1px 0px 0px #eaeaea;
}
#rightBtn{
	margin-top		: 65px;
    float			: right;
    margin-right	: -40px;
    width			: 35px;
    height			: 60px;
    border			: 1px solid #d4d4d4;
    border-radius	: 1px 5px 5px 0px;
    text-align		: center;
    line-height		: 48px;
    color			: #8c8c8c;
    border-left 	: 0;
    z-index			: 99999;
    background		: #ffffff;
    cursor			: pointer;
    box-shadow		: 1px 1px 0px 0px #eaeaea;
}
.check-list-table {
	border-bottom	: 2px solid #c3c3c3;
    margin-top		: 35px;
    padding-left	: 10px;
}
.check-list-div {
	height 			: 300px;
	border-bottom 	: 1px solid #d4d4d4;
	overflow		: auto;
}
#memoTextarea {
	width 			: 100%;
	height 			: 100px;
	padding 		: 5px;
}
.btn-add {
	margin-top 		: -25px;
}
.check_list_title {
	height 			: 24px !important;
}
.check_list_update_btn {
	color 			: #6670dc;
}
.check_list_update_btn:hover, .check_list_delete_btn:hover{
	font-weight 	: bold;
}
.check_list_detail:hover {
	border			: 1px solid #6694dc;
    border-radius	: 3px;
    box-shadow		: 1px 1px 0px 0px #ececec;
}
#memoSaveBtn {
	margin-top 		: -27px;
}
.check_list_update_input {
	width 			: 200px;
	height 			: 22px;
}
</style>


<script type="text/javascript">
$(function () {
	
});
</script>

<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
	
    <!-- Sidebar - Brand -->
	<a class="sidebar-brand d-flex align-items-center justify-content-center" href="/views/dashboard">
		<div class="sidebar-brand-icon rotate-n-15">
        	<i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">HOMES</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
		<a class="nav-link" href="/views/dashboard">
        	<i class="fas fa-fw fa-tachometer-alt"></i>
          	<span>Dashboard</span>
      	</a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Interface
    </div>

	<li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTw" aria-expanded="true" aria-controls="collapseTwo">
          	<i class="fas fa-fw fa-cog"></i>
          	<span>부동산</span>
        </a>
        <div id="collapseTw" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          	<div class="bg-white py-2 collapse-inner rounded">
	            <a class="collapse-item" href="/views/realEstate/manage/list">부동산 관리</a>
          	</div>
        </div>
    </li>
    
    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
      	<button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>
<!-- End of Sidebar -->
<!-- 
<div id="checkMemoDiv">
	우측 open / close 버튼
	<div id="rightBtn" show="off">&gt;</div>
	
	header
	<div class="check-list-table">
		<h4>체크 리스트</h4>
		<button type="button" class="btn btn-default btn-xs float-right btn-add" id="checkListAddBtnaa">+</button> 
	</div>
	
	check list
	<div class="check-list-div">
		<table class="table" id="checkListTable1">
			<colgroup>
				<col width="10%"/>
				<col width="auto"/>
			</colgroup>
			<tbody>
				<tr class="check_list_empty">
					<td colspan="2" class="text-center">체크 항목이 없습니다.</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div>
		<h5>Memo</h5>
		<button type="button" class="btn btn-primary btn-xs float-right" id="memoSaveBtn" idx="">메모 저장</button>
		<textarea id="memoTextarea" class="form-control"></textarea>
	</div>
</div> 
-->