<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

	<title><tiles:getAsString name="title"/></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	
<!--------------------------------- CSS LINK START --------------------------------->
	
	<!-- default css -->
	<link rel="stylesheet" href="/css/common/reset.min.css">

	<!--external css-->
	<link href="/lib/Dashio/lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="/lib/Dashio/css/zabuto_calendar.css">
	<link rel="stylesheet" type="text/css" href="/lib/Dashio/lib/gritter/css/jquery.gritter.css" />

	<!-- bootstrap -->
	<link rel="stylesheet" href="/webjars/bootstrap/3.3.4/dist/css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="/webjars/bootstrap/3.3.4/dist/css/bootstrap.min.css">
	
	<!-- Custom styles for this template -->
	<link href="/lib/Dashio/css/style.css" rel="stylesheet">
	<link href="/lib/Dashio/css/style-responsive.css" rel="stylesheet">
	
	<!-- ScheManager CSS -->
	<link rel="stylesheet" href="/css/common/base.css">
	<link rel="stylesheet" href="/css/common/common.css">

<!--------------------------------- CSS LINK END --------------------------------->
	
	
	
<!--------------------------------- JS LINK START --------------------------------->
	
	<!-- jquery -->
	<script type="text/javascript" src="/webjars/jquery/3.3.1/dist/jquery.min.js"></script>
	
	<!-- bootstrap -->
	<script type="text/javascript" src="/lib/Dashio/lib/bootstrap/js/bootstrap.min.js"></script>
	
	<!-- amChart -->
	<script type="text/javascript" src="/lib/amChart/core.js"></script>
	<script type="text/javascript" src="/lib/amChart/charts.js"></script>
	
	<!-- jqGrid -->
	<link rel="stylesheet" href="/lib/Guriddo_jqGrid_JS_5.3.2/css/ui.jqgrid.css">
	<link rel="stylesheet" href="/lib/jquery-ui-1.12.1.custom/jquery-ui.theme.min.css">
	<script type="text/javascript" src="/lib/Guriddo_jqGrid_JS_5.3.2/js/jquery.jqGrid.min.js"></script>
	
	<!-- vue -->
	<script type="text/javascript" src="/js/vue.js"></script>
	<script type="text/javascript" src="/js/axios.min.js"></script>
	
	<!-- common -->
	<script type="text/javascript" src="/js/common.js"></script>
	
<!--------------------------------- JS LINK END --------------------------------->
	


<!--------------------------------- IMAGE LINK START --------------------------------->	

	<!-- dashio -->
	<!-- Favicons -->
	<link href="/lib/Dashio/img/favicon.png" rel="icon">
	<link href="/lib/Dashio/img/apple-touch-icon.png" rel="apple-touch-icon">
	<link rel="stylesheet" type="text/css" href="/lib/Dashio/lib/bootstrap-datepicker/css/datepicker.css" />
	<link rel="stylesheet" type="text/css" href="/lib/Dashio/lib/bootstrap-daterangepicker/daterangepicker.css" />
	<link rel="stylesheet" type="text/css" href="/lib/Dashio/lib/bootstrap-timepicker/compiled/timepicker.css" />

<script type="text/javascript" src="/lib/Dashio/lib/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="/lib/Dashio/lib/bootstrap-daterangepicker/date.js"></script>
<script type="text/javascript" src="/lib/Dashio/lib/bootstrap-daterangepicker/daterangepicker.js"></script>
<script type="text/javascript" src="/lib/Dashio/lib/bootstrap-daterangepicker/moment.min.js"></script>
<script src="/lib/Dashio/lib/advanced-form-components.js"></script>
<!--------------------------------- IMAGE LINK END --------------------------------->

	<script type="text/javascript">
	var thisUrl = location.href;
	
	$(function(){

		if ($(window).width() < 768) {
			
			$('#sidebar').attr("show", "close");
			$('#sidebar').css({"top":"-880px", "left":"0px"});
		}
		
		// ë©ë´ Click Event
		$('.sidebar-toggle-box').unbind("click").click(function(){
			
			// ë¸ë¼ì°ì  ì¬ì´ì¦
			var scnSize = $(window).width();
			
			// ë¸ë¼ì°ì  ì¬ì´ì¦ê° 768 ì´í ì¼ ê²½ì°
			if ( scnSize < 768 ){
				
				// ë©ë´ë° ìì±ê°ì´ open ì¼ ê²½ì° í´ë¦­ì close ìíë¡ ë³ê²½ëë©° ë©ë´ë° ë«í
				if( $('#sidebar').attr("show") == "open" ){
					
					$('#sidebar').animate({top: "-880px"}, 500);
					$('#sidebar').attr("show", "close");
					$('footer').css("width", "100%");
					
				
				// ë©ë´ë° ìì±ê°ì´ close ì¼ ê²½ì° í´ë¦­ ì open ìíë¡ ë³ê²½ëë©° ë©ë´ë° ì´ë¦¼
				} else {
					
					$('#sidebar').animate({top: "0"}, 500);
					$('#sidebar').attr("show", "open");
					$('footer').css("width", "100%");
					
				}
			
			// ë¸ë¼ì°ì  ì¬ì´ì¦ê° 768 ì´ì ì¼ ê²½ì°
			} else {

				// ë©ë´ë° ìì±ê°ì´ open ì¼ ê²½ì° í´ë¦­ì close ìíë¡ ë³ê²½ëë©° ë©ë´ë° ë«í
				if( $('#sidebar').attr("show") == "open" ){
					
					$('#sidebar').animate({left: "-210px"}, 500);
					$('#sidebar').attr('show', 'close');
					$('#main-content').animate({marginLeft: "0px"}, 500);
					$('footer').animate({left: "0px", width: "100%"}, 500);
					
				// ë©ë´ë° ìì±ê°ì´ close ì¼ ê²½ì° í´ë¦­ ì open ìíë¡ ë³ê²½ëë©° ë©ë´ë° ì´ë¦¼
				} else {
					
					$('#sidebar').css("top", "0px");
					$('#sidebar').animate({left: "0px", top : "0"}, 500);
					$('#main-content').animate({marginLeft: "210px"}, 500);
					$('footer').animate({left: "210px", width:"calc(100% - 210px)"}, 500);
					$('#sidebar').attr('show', 'open');
					
				}
				
			}
			
		});
	
		// Screen Size ê°ì§
		$(window).resize(function(){
			
			var scnSize = $(window).width();

			// ë³ê²½ ë ë¸ë¼ì°ì  ì¬ì´ì¦ê° 768 ì´í ì¼ ê²½ì°
			if( scnSize < 768 ){
				
				$('#sidebar').css({"top":"-880px", "left":"0px"});
				$('#sidebar').attr("show", "close");
				$('footer').css({"width":"100%", "left":"0px"});
				
			// ë³ê²½ ë ë¸ë¼ì°ì  ì¬ì´ì¦ê° 768 ì´ì ì¼ ê²½ì°
			} else {

				// ì¬ì´ì¦ ë³ê²½ ì ì ë©ë´ë°ê° open ìíì¸ ê²½ì° ì¬ì´ì¦ ë³ê²½ íìë open ìí ì ì§
				if( $('#sidebar').attr("show") == "open" ){
					
					$('#sidebar').css("top", "0px");
					$('#sidebar').css({"top":"0px", "left":"0px"});
					$('#main-content').css("margin-left", "210px");
					$('footer').css({"width":"calc(100% - 210px)", "left":"210px"});

				// ì¬ì´ì¦ ë³ê²½ ì ì ë©ë´ë°ê° close ìíì¸ ê²½ì° ì¬ì´ì¦ ë³ê²½ íìë close ìí ì ì§
				} else {
					
					$('#sidebar').css({"top":"0px", "left":"-210px"});
					$('#main-content').css("margin-left", "0px");
					$('footer').css({"width":"100%", "left":"0px"});
					
				}
			}
			
		});

		getMenuSetting();
	});
	</script>
</head>
<body>

	<div class="wrap">

		<tiles:insertAttribute name="header" />

		<tiles:insertAttribute name="menu" />
		
		<section id="main-content">
			<section class="wrapper">
				<div class="this-sm-title-div" style="display:none;"><h5 id="thisSmTitle"></h5></div>
				<h3 id="thisTitle"></h3>
				<tiles:insertAttribute name="body" />
			</section>
		</section>
		
		<tiles:insertAttribute name="footer" />
		
	</div>

</body>
</html>