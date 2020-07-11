<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function () {
	
	var cookieCheck = common.cookie.getCookie('check');
	if (cookieCheck == 'true') {
		$('#customCheck').prop('checked', true);
		$('#email').val(common.cookie.getCookie('email'));
		$('#password').val(common.cookie.getCookie('pass'));
	}
	
	// 로그인
	$('#loginBtn').unbind('click').click(function () {
		// 아이디, 패스워드 cookie 저장
		if ($('#customCheck').prop('checked')) {
			
			common.cookie.setCookie('check'	, 'true'				, 365);
			common.cookie.setCookie('email'	, $('#email').val()		, 365);
			common.cookie.setCookie('pass'	, $('#password').val()	, 365);
			
		// cookie 삭제
		} else {
			
			common.cookie.deleteCookie('check');
			common.cookie.deleteCookie('email');
			common.cookie.deleteCookie('pass');
		}
		
		$('#loginForm').submit();
	});
	
});
</script>
<div class="row justify-content-center">

	<div class="col-xl-6 col-lg-12 col-md-9">
		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="row">
					<div class="col-lg-12">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">Welcome HOMES!</h1>
							</div>
							<form class="user" id="loginForm" method="POST">
								<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
								<div class="form-group">
									<input 
										type="text"
										name="username"
										class="form-control form-control-user" 
										id="email" 
										placeholder="Enter Email Address...">
								</div>
								<div class="form-group">
									<input 
										type="password" 
										name="password"
										class="form-control form-control-user" 
										id="password" 
										placeholder="Password">
								</div>
								<div class="form-group">
									<div class="custom-control custom-checkbox small">
										<input type="checkbox" class="custom-control-input" id="customCheck">
										<label class="custom-control-label" for="customCheck">Remember Me</label>
									</div>
								</div>
								<button type="button" id="loginBtn" class="btn btn-primary btn-user btn-block">Login</button>
							</form>
							<hr>
							<div class="text-center">
								<a class="small" href="forgot-password.html">Forgot Password?</a>
							</div>
							<div class="text-center">
								<a class="small" href="register.html">Create an Account!</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>