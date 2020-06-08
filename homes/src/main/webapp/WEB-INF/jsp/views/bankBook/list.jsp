<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
</style>
<script type="text/javascript">
$(function () {
	
	$.ajax({
		url 		: '/bankBook/list',
		data 		: {},
		type 		: 'POST',
		dataType 	: 'JSON'
		
	// 결과
	}).done(function (result) {
		
		
		if (result.status) {
			
			// 초기화
			$('#bankBookTable tbody').empty();
			
			$.each(result.list, function (i, item) {
				var html  = '<tr>';
					html += '	<td>' + (i + 1) + '</td>';
					html += '</tr>';
					
				$('#bankBookTable tbody').append(html);
			});
			
			// 데이터 없을 때
			if (result.list.length == 0) {
				$('#bankBookTable tbody').append('<tr><td>데이터가 없습니다.</td></tr>');
			}
		}
	});
	
});
</script>

<div>
	<table id="bankBookTable" class="table">
	
		<thead>
			<tr>
				<th>번호</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</div>