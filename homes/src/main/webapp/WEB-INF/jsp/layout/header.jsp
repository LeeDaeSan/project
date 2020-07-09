<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.ds.homes.tools.util.DateUtil"%>

<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
	<div><%= DateUtil.dateToString(new Date(), "yyyy년 MM월 dd일, EEE요일") %></div>
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
	        	<div class="dropdown-divider"></div>
	        	<a class="dropdown-item" href="/logout">
	          		<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
	          		Logout
	        	</a>
	      	</div>
	    </li>
	</ul>
</nav>