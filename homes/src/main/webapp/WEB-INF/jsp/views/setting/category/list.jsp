<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.panel-body{height:500px;overflow-y:auto;}
.list-group-table tr td{padding:3px;}
.form-control{height:25px !important;}

.selected{background:#d2d2d2;font-weight:bold;}
ul.list-group li.list-group-item{cursor:pointer;}
ul.list-group li.list-group-item:hover{background:#e6e6e6;font-weight:bold;}

#category1Ul, #category2Ul, #category3Ul{height:500px;overflow:auto;}
.list-group-item{padding:6px 4px 6px 8px !important;}
</style>
<script type="text/javascript">
var choiceCategory1 = '';
var choiceCategory2 = '';

$(function () {
	
	list(1);
	
	// 카테고리1 등록 팝업 버튼
	$('.category_popup_btn').unbind('click').click(function (e) {
		e.preventDefault();
		var level = $(this).attr('level');
		
		if (level == 2) {
			if (!choiceCategory1) {
				alert('대분류 코드가 선택되지 않았습니다.');
				return false;
			} else {
				$('#category2Modal').modal();
			}
			
		} else if (level == 3) {
			if (!choiceCategory2) {
				alert('중분류 코드가 선택되지 않았습니다.');
				return false;
			} else {
				$('#category3Modal').modal();
			}
		}
		
		lastCode(level);
	});
	
	// 등록 버튼
	$('.insert_category_btn').unbind('click').click(function (e) {
		e.preventDefault();
		var thisLevel = $(this).attr('level');
		
		var parentIdx = null;
		
		if (thisLevel == 2 || thisLevel == 3) {
			parentIdx = $('#category' + (Number(thisLevel) - 1) + 'Idx').val();
		}
		
		$.ajax({
			url 		: '/rest/category/change',
			method 		: 'POST',
			dateType 	: 'JSON',
			data 		: {
				categoryCode 	: $('#categoryCode' + thisLevel).val(),
				categoryName 	: $('#categoryName' + thisLevel).val(),
				level			: thisLevel,
				type			: 'I',
				parentIdx		: parentIdx
			},
			success : function (result) {
				if (result.status) {
					
					// success
					if (result.result == 1) {
						alert('등록하였습니다.');
						lastCode(thisLevel);
						$('#categoryName' + thisLevel).val('');
						
						list(thisLevel);
						
					} else {
						alert('등록중 에러가 발생하였습니다.');
					}
					
				} else {
					alert('서버 에러');
				}
			}
		});
	});
});

function lastCode (level) {
	
	$.ajax({
		url 		: '/rest/category/code',
		method 		: 'POST',
		dataType 	: 'JSON',
		data 		: {
			level : level
		},
		success 	: function (result) {
			
			if (result.status) {
	
				if (level == 1) {
					var code = 'A001';
					
					if (result.code) {
						var codeHead 	= result.code.substring(0, 1);
						var codeNum 	= Number(result.code.substring(1));
						code = codeHead + common.number.pad(++codeNum, 3);
					}
					
					
				} else if (level == 2) {
					var code = choiceCategory1 + '-B001';
					if (result.code) {
						var codeHead 	= result.code.substring(0, 6);
						var codeNum 	= Number(result.code.substring(6));
						code = codeHead + common.number.pad(++codeNum, 3);
					}
					
				} else if (level == 3) {
					var code = choiceCategory2 + '-C001';
					if (result.code) {
						var codeHead 	= result.code.substring(0, 11);
						var codeNum		= Number(result.code.substring(11));
						code = codeHead + common.number.pad(++codeNum, 3);
					}
				}
				
				$('#categoryCode' + level).val(code);
			}
		}
	});
}

function list (level) {

	var parentIdx = null;
	if (level == 2 || level == 3) {
		parentIdx = $('#category' + (Number(level) - 1) + 'Idx').val();
	}
	
	$.ajax({
		url 		: '/rest/category/list',
		method 		: 'POST',
		dataType 	: 'JSON',
		async		: false,
		data 		: {
			level		: level,
			parentIdx	: parentIdx
		},
		success 	: function (result) {
			if (result.status) {

				var html = '';
				var list = result.list;
				var listLength = list.length;
				for (var i = 0; i < listLength; i++) {
					var thisData = list[i];
					
					html += '<li class="list-group-item category_li" level="' + level + '" idx="' + thisData.categoryIdx + '" code="' + thisData.categoryCode + '">' + thisData.categoryName + '</li>';
				}
				
				if (listLength == 0) {
					html = '<li class="list-group-item data_empty">코드가 없습니다.</li>';
				}
				$('#category' + level + 'Ul').empty().append(html);
			}
		}
	});
	
	// li click event
	$('.category_li').unbind('click').click(function (e) {
		e.preventDefault();

		var thisLevel = $(this).attr('level');
		
		// 선택자 selected 클래스 추가
		$('.category_li').each(function () {
			if (thisLevel == $(this).attr('level')) {
				$(this).removeClass('selected');
			}
		});
		$(this).addClass('selected');
		
		// 중분류 타이틀 우측 현재코드 보이기
		$('#category' + (Number(thisLevel) + 1) + 'Parent').text('[' + $(this).text() + ']');
		$('#category' + thisLevel + 'Idx').val($(this).attr('idx'));
		
		if (thisLevel == 1) {
			choiceCategory1 = $(this).attr('code');
		} else if (thisLevel == 2) {
			choiceCategory2 = $(this).attr('code');
		}
		
		// 하위 분류 목록 조회
		list(++thisLevel);
		
		/* 
		$.ajax({
			url 		: '/rest/category/detail',
			method 		: 'POST',
			dataType 	: 'JSON',
			data 		: {
				idx 		: $(this).attr('idx'),
				level 		: thisLevel
			},
			success		: function (result) {
				console.log(result);
			}
		});
		 */
		
	});
}
</script>

<div class="row container-fluid">
	<!-- 대분류 -->
	<div class="col-lg-4">
		<div class="card mb-4">
        	<div class="card-header">대분류 코드</div>
            <div class="card-body">
            	<ul class="list-group" id="category1Ul">
					<li class="list-group-item data_empty">코드가 없습니다.</li>
				</ul>
            </div>
            <div class="card-footer text-center">
            	<button class="btn btn-primary btn-sm category_popup_btn" level="1" data-toggle="modal" data-target="#category1Modal">추가하기</button>
            </div>
        </div>
	</div>
	
	<!-- 중분류 -->
	<div class="col-lg-4">
		<div class="card mb-4">
        	<div class="card-header">
        		중분류 코드
        		<span id="category2Parent"></span>
				<input type="hidden" id="category1Idx"/>
			</div>
            <div class="card-body">
            	<ul class="list-group" id="category2Ul">
					<li class="list-group-item data_empty">코드가 없습니다.</li>
				</ul>
       		</div>
       		<div class="card-footer text-center">
       			<button class="btn btn-primary btn-sm category_popup_btn" level="2" data-toggle="modal">추가하기</button>
      		</div>
   		</div>
    </div>
	
	<!-- 소분류 -->
	<div class="col-lg-4">
		<div class="card mb-4">
        	<div class="card-header">
        		소분류 코드
        		<span id="category3Parent"></span>
				<input type="hidden" id="category2Idx"/>
       		</div>
            <div class="card-body">
            	<ul class="list-group" id="category3Ul">
					<li class="list-group-item data_empty">코드가 없습니다.</li>
				</ul>
       		</div>
       		<div class="card-footer text-center">
       			<button class="btn btn-primary btn-sm category_popup_btn" level="3" data-toggle="modal">추가하기</button>
      		</div>
   		</div>
    </div>
</div>

<!-- 대분류 등록 Modal -->
<div class="modal fade" id="category1Modal" tabindex="-1" role="dialog" aria-labelledby="category1ModalLabel">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="category1ModalLabel">대분류 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table">
					<colgroup>
						<col width="30%"/>
						<col width="auto"/>
					</colgroup>
					<tr>
						<th>코드</th>
						<td><input type="text" id="categoryCode1" class="form-control" readOnly/></td>
					</tr>
					<tr>
						<th>분류명</th>
						<td><input type="text" id="categoryName1" class="form-control"/></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-sm insert_category_btn" level="1">등록</button>
				<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 중분류 등록 Modal -->
<div class="modal fade" id="category2Modal" tabindex="-1" role="dialog" aria-labelledby="category2ModalLabel">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="category2ModalLabel">중분류 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table">
					<colgroup>
						<col width="30%"/>
						<col width="auto"/>
					</colgroup>
					<tr>
						<th>코드</th>
						<td><input type="text" id="categoryCode2" class="form-control" readOnly/></td>
					</tr>
					<tr>
						<th>분류명</th>
						<td><input type="text" id="categoryName2" class="form-control"/></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-sm insert_category_btn" level="2">등록</button>
				<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<!-- 소분류 등록 Modal -->
<div class="modal fade" id="category3Modal" tabindex="-1" role="dialog" aria-labelledby="category3ModalLabel">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="category3ModalLabel">소분류 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table">
					<colgroup>
						<col width="30%"/>
						<col width="auto"/>
					</colgroup>
					<tr>
						<th>코드</th>
						<td><input type="text" id="categoryCode3" class="form-control" readOnly/></td>
					</tr>
					<tr>
						<th>분류명</th>
						<td><input type="text" id="categoryName3" class="form-control"/></td>
					</tr>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-sm insert_category_btn" level="3">등록</button>
				<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>