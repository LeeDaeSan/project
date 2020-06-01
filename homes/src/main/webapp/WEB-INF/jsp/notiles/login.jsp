<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"></script>
</head>
<body>

<form method="POST">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
	<table>
		<tr>
			<th>
				<label for="email">Email</label>
			</th>
			<td>
				<input type="text" id="email" name="username"/>
			</td>
		</tr>
		<tr>
			<th>
				<label for="password">Password</label>
			</th>
			<td>
				<input type="text" id="password" name="password"/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="로그인"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>