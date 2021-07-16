<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../../../../lib/sbadmin2/css/all.min.css" />
	<link rel="stylesheet" href="../../../../lib/sbadmin2/css/sb-admin-2.min.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<script src="/webjars/jquery/3.3.1/dist/jquery.min.js"></script>
</head>
<body>

	<div id="default">
		<div class="card mb-4">
			<div class="card-header">
				아파트 기본 정보
			</div>
			<div class="card-body">
				<div class="sbp-preview">
					<div class="bd-example">
						<form class="">
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="aptName">아파트명</label>
								<div class="col-sm-10">
									<input class="form-control" id="aptName">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="address">주소지</label>
								<div class="col-sm-10">
									<input class="form-control" id="address">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2 col-form-label" for="station">지하철역</label>
								<div class="col-sm-10">
									<input class="form-control" id="station">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>