<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HOMES</title>
		
		<!--------------------------------- CSS LINK START --------------------------------->
		
		<!-- fontawesome -->
		<link rel="stylesheet" type="text/css" href="/lib/sbadmin2/css/all.min.css"/>
		<!-- SB Admin 2 -->
		<link rel="stylesheet" type="text/css" href="/lib/sbadmin2/css/sb-admin-2.min.css"/>
		<!-- bootstrap datepicker -->
		<link rel="stylesheet" type="text/css" href="/lib/bootstrap/bootstrap-datepicker.min.css"/>
		<!-- common -->	
		<link rel="stylesheet" type="text/css" href="/css/common.css"/>
		<!--------------------------------- CXX LINK END --------------------------------->
				
				
		<!--------------------------------- JS LINK START --------------------------------->
		
		<!-- jQuery -->		
		<script type="text/javascript" src="/webjars/jquery/3.3.1/dist/jquery.min.js"></script>
		<!-- bootstrap bundle -->		
		<script type="text/javascript" src="/lib/sbadmin2/js/bootstrap.bundle.min.js"></script>
		<!-- jQuery easing -->		
		<script type="text/javascript" src="/lib/sbadmin2/js/jquery.easing.min.js"></script>
		<!-- SB Admin 2 -->
		<script type="text/javascript" src="/lib/sbadmin2/js/sb-admin-2.min.js"></script>
		<!-- common js -->
		<script type="text/javascript" src="/js/common.js"></script>
		<!-- bootstrap datepicker -->
		<script type="text/javascript" src="/lib/bootstrap/bootstrap-datepicker.js"></script>
		
		<!--------------------------------- JS LINK END --------------------------------->
			
	</head>
	
	<body id="page-top">
		<div id="wrapper">
			<tiles:insertAttribute name="leftMenu"/>
			
			<!-- Content Wrapper -->
		    <div id="content-wrapper" class="d-flex flex-column">
		    	<!-- Main Content -->
		      	<div id="content">
					<tiles:insertAttribute name="header"/>
	
					<tiles:insertAttribute name="body"/>
					
					<tiles:insertAttribute name="footer"/>
				</div>
			</div>
		</div>
	</body>
</html>