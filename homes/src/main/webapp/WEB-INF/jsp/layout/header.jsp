<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>

</style>

<script type="text/javascript">
$(function () {
	var url = location.href;
	
	$('.header_tabs li a').each(function (e) {
		if (url.indexOf($(this).attr('href')) != -1) {
			$(this).closest('li').addClass('active');			
		}
	});
});
</script>
<ul class="nav nav-tabs header_tabs">
  <li role="presentation"><a href="/views/main">Home</a></li>
  <li role="presentation"><a href="/views/bankBook/list">가계부</a></li>
  <li role="presentation"><a href="#">Messages</a></li>
</ul>