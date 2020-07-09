<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
$(function () {
	
	$.ajax({
		url 		: '/rest/bankBookDetail/calculate/list',
		method		: 'POST',
		dataType	: 'JSON',
		async		: false,
		data		: {},
		
	}).done(function (result) {
		console.log(result);
		
	}).fail(function (result) {
		
	});
});
</script>
<div class="container-fluid">
	<h4 class="mb-2 text-gray-800">정산</h4>
	
	<!-- list START -->
    <div class="card shadow mb-4">
	    <div class="card-header py-3">
	      	<h6 class="m-0 font-weight-bold text-primary">정산 목록</h6>
	    </div>
	    
	    <div class="card-body">
          	<div class="table-responsive">
               	<table class="table table-bordered" id="bankBookTable">
               		<colgroup>
						<col width="7%"/>
						<col width="7%"/>
						<col width="15%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="10%"/>
						<col width="9%"/>
					</colgroup>
               		<thead>
                   		<tr>
							<th class="text-center">수입</th>
							<th class="text-center">지출</th>
							<th class="text-center">남은 잔액</th>
                   		</tr>
                   		<tr>
                   			<th class="text-center"></th>
                   			<th class="text-center"></th>
                   			<th class="text-center"></th>
                   			<th class="text-center"></th>
                   		</tr>
                 	</thead>
               		<tbody>
               		</tbody>
              	</table>	
           	</div>
       	</div>
       	
    </div>
</div>
	
