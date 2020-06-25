<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Real Estate</title>
		
		<link rel="stylesheet" type="text/css" href="/api/bootstrap/bootstrap.min.css"/>
		
		<!--------------------------------- JS LINK START --------------------------------->
	
		<!-- jquery -->
		<script type="text/javascript" src="/webjars/jquery/3.3.1/dist/jquery.min.js"></script>
		
		<!-- bootstrap -->
		<script type="text/javascript" src="/api/bootstrap/bootstrap.min.js"></script>
		
		<!-- common js -->
		<script type="text/javascript" src="/js/common.js"></script>
		
		<!--------------------------------- JS LINK END --------------------------------->

		<style>
		.wrap .wrap-body{margin:5px;}
		</style>
	</head>
	<body>
		<div class="wrap">
			<section>
				<section class="wrapper">
					<tiles:insertAttribute name="empty" />
				</section>
			</section>
		</div>
	</body>
</html>