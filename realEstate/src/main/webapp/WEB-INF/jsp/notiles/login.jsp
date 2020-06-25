<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.login-div{
	text-align 		: center;
	width			: 290px;
	margin			: 0 auto;
	margin-top		: 10%;
	border			: 1px solid #c7c7c7;
	padding			: 10px;
	border-radius 	: 5px;
}
.login-div table {
	margin-bottom : 0;
}
.login-title {
	margin : 0;
}
</style>
<script></script>

<div class="login-div">
	<form method="POST">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
		<table class="table">
			<thead>
				<tr>
					<td colspan="2" class="text-left">
						<h3 class="login-title float-left">LOGIN</h3>
						<h5 class="float-right">Real Estate</h5>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>
						<label for="email">Email</label>
					</th>
					<td>
						<input type="text" id="email" name="username" class="form-control" placeholder="이메일을 입력해 주세요."/>
					</td>
				</tr>
				<tr>
					<th>
						<label for="password">Password</label>
					</th>
					<td>
						<input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력해 주세요."/>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인" class="btn btn-default"/>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
