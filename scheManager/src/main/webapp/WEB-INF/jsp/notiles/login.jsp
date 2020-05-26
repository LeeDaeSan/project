<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.login-form{width:200px;margin:0 auto;}
</style>

<script type="text/javascript">
$(function () {
	
	//회원가입 페이지 이동
	$('#joinBtn').unbind('click').click(function () {
		location.href = '/notiles/join';
	});
});
</script>

<form class="login-form" method="POST">
	<input type ="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
  	<div class="row">
  		<table class="table">
  			<tr>
  				<th>
		      		<label for="email">Email</label>
  				</th>
  				<td>
		      		<input id="email" name="username" class="validate"/>
  				</td>
  			</tr>
  			<tr>
  				<th>
		      		<label for="password">Password</label>
  				</th>
  				<td>
		      		<input id="password" type="password" name="password" class="validate"/>
  				</td>
  			</tr>
  			<tr>
  				<td colspan="2" class="tc">
			  		<input class="login-btn waves-effect waves-light btn" type="submit" value="로그인" />
			  		<input class="login-btn waves-effect waves-light btn" type="button" value="회원가입" id="joinBtn"/>
  				</td>
  			</tr>
  		</table>
  	</div>
  	
</form>