<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title><tiles:getAsString name="title"/></title>
	<meta charset="UTF-8">
	
<!--------------------------------- JS LINK START --------------------------------->
	
	<!-- jquery -->
	<script type="text/javascript" src="/webjars/jquery/3.3.1/dist/jquery.min.js"></script>
	
	<!-- bootstrap -->
	<script type="text/javascript" src="/api/bootstrap/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/api/bootstrap/bootstrap.min.css"/>
	
<!--------------------------------- JS LINK END --------------------------------->
</head>
<body>
	
	<div class="wrap">
		<tiles:insertAttribute name="header"/>
		
		<section>
			<tiles:insertAttribute name="body"/>
		</section>
		
		<tiles:insertAttribute name="footer"/>
	</div>
</body>
</html>