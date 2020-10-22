<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.level_1 {

}
.level_other {
	display : none;
}
.list-group-item {
	cursor : pointer;
}
.add-item-li input {
	width : 90%;
}
</style>
<script type="text/javascript">
$(function () {
	
	accountCategoryList();
	
});

function accountCategoryList () {
	
	$.ajax({
		url 	: '/rest/accountCategory/list',
		method 	: 'POST',
		async	: false,
		
	}).done(function (result) {
		
		// 목록 초기화
		$('#accountCategoryUl').empty();
		
		var list 		= result.list;
		var listLength 	= list.length;
		
		for (var i = 0; i < listLength; i++) {
			var thisData 	= list[i];	
			var level 		= thisData.level;
			var categoryIdx = thisData.categoryIdx;
			var parentIdx	= thisData.parentIdx;
			
			var levelNbsp = '&nbsp;';
			
			if (level == 2) {
				levelNbsp = '&nbsp;&nbsp;';
			} else if (level == 3) {
				levelNbsp = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			} else if (level == 4) {
				levelNbsp = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			} else if (level == 5) {
				levelNbsp = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			}
			
			var html  = '<li class="list-group-item ' + (level > 1 ? 'level_other' : '') + '" categoryIdx="' + categoryIdx + '" parentIdx="' + parentIdx + '">';
				
				html += 	(level > 1 ? levelNbsp + 'ㄴ&nbsp;' : '') + thisData.categoryName;
				/* if (level > 1) { */
					html += '	<button class="btn btn-primary btn-sm float-right add_category_btn">+</button>';
				/* } */
				html += '</li>';
			
			$('#accountCategoryUl').append(html);
		}
		
		// slide up / down event
		$('.list-group-item').unbind('click').click(function (e) {
			e.preventDefault();
			var isShow		= $(this).prop('show');
			var categoryIdx = $(this).attr('categoryIdx');
			var parentIdx 	= $(this).attr('parentIdx');
			
			$('.list-group-item').each(function () {
				var thisParentIdx = $(this).attr('parentIdx');
				if (categoryIdx == thisParentIdx) {
					if (!isShow) {
						$(this).slideDown();
					} else {
						$(this).slideUp();
					}
				}
			});
			
			$(this).prop('show', !isShow);
		});
		
		// add event
		$('.add_category_btn').not('.list-group-item').unbind('click').click(function (e) {
			e.preventDefault();
			e.stopPropagation();
			
			var html  = '<li class="list-group-item add-item-li">';
				html += '	<span class="float-left">&nbsp;ㄴ&nbsp;</span>';
				html += '	<input type="text" class="form-control float-left category_name" parentIdx="' + $(this).closest('li').attr('categoryIdx') + '"/>';
				html += '	<button type="button" class="btn btn-primary btn-sm float-right category_add_btn">등록</button>';
				html += '</li>';
			$(this).closest('li').after(html);

			// 등록
			$('.category_add_btn').unbind('click').click(function (e) {
				e.preventDefault();
				e.stopPropagation();
				
				var thisLi = $(this).closest('li');
				
				$.ajax({
					url 		: '/rest/accountCategory/merge',
					method		: 'POST',
					dataType	: 'JSON',
					data		: {
						type			: 'I',
						parentIdx 		: thisLi.find('.category_name').attr('parentIdx'),		
						categoryName 	: thisLi.find('.category_name').val(),
					},
					
				}).done(function (result) {
					if (result.status) {
						alert('등록이 완료되었습니다.');						
						
					} else {
						alert('서버 에러');
					}
				});
			});
		});
		
		
	});
	
}

</script>

<div class="container-fluid">
	<h4 class="mb-2 text-gray-800">가계부 카테고리 관리</h4>
	
		<!-- list START -->
    <div class="card shadow mb-4">
	    <div class="card-header py-3">
	      	<h6 class="m-0 font-weight-bold text-primary">카테고리 목록</h6>
	    </div>
    	<div class="card-body">
          	<div class="table-responsive">
               	<ul class="list-group" id="accountCategoryUl">
              	</ul>
           	</div>
       	</div>
   	</div>
   	
</div>