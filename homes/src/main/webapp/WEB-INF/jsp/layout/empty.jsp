<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HOMES</title>
		
		<title>HOMES</title>
		
		<!--------------------------------- CSS LINK START --------------------------------->
		<!-- fontawesome -->
		<link href="/lib/sbadmin2/css/all.min.css" rel="stylesheet" type="text/css">
		<!-- SB Admin 2 -->
		<link href="/lib/sbadmin2/css/sb-admin-2.min.css" rel="stylesheet">
		<!-- 
		bootstrap css
		<link rel="stylesheet" type="text/css" href="/api/bootstrap/bootstrap.min.css"/>
		common css
		<link rel="stylesheet" type="text/css" href="/css/common.css"/>
		-->	
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
		
		<!--------------------------------- JS LINK END --------------------------------->
			
	</head>
	<body class="bg-gradient-primary">
		<div class="container">
			<tiles:insertAttribute name="empty" />
		</div>
	</body>
</html>