<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>HOMES</title>
	<meta charset="UTF-8">
	
<!--------------------------------- CSS LINK START --------------------------------->

	<!-- bootstrap css -->
	<link rel="stylesheet" type="text/css" href="/api/bootstrap/bootstrap.min.css"/>
	<!-- common css -->
	<link rel="stylesheet" type="text/css" href="/css/common.css"/>
	<!-- datepicker css -->
	<link rel="stylesheet" type="text/css" href="/api/bootstrap/bootstrap-datepicker.min.css"/>
	
<!--------------------------------- CXX LINK END --------------------------------->

	
<!--------------------------------- JS LINK START --------------------------------->
	
	<!-- jquery -->
	<script type="text/javascript" src="/webjars/jquery/3.3.1/dist/jquery.min.js"></script>
	<!-- bootstrap js -->
	<script type="text/javascript" src="/api/bootstrap/bootstrap.min.js"></script>
	<!-- common js -->
	<script type="text/javascript" src="/js/common.js"></script>
	<!-- datepicker js -->
	<script type="text/javascript" src="/api/bootstrap/bootstrap-datepicker.js"></script>
	
<!--------------------------------- JS LINK END --------------------------------->

	

	<style>
	.wrap{margin:5px;}
	.wrap .wrap-body{margin:5px;}
	</style>
</head>
<body>
	
	<div class="wrap">
		<tiles:insertAttribute name="header"/>

		<div class="wrap-body">
			<tiles:insertAttribute name="body"/>
		</div>		
		
		<tiles:insertAttribute name="footer"/>
	</div>
</body>
</html>