<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(function () {

	// 목록 Handler
	var userList = new Vue({
		el	: '#userList',
		mounted () {
			
			var param = {
					
			};
			
			// [필수설정]
			axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
			// Promise
			axios.post('/member/list', param).then(response => {
				if (response.status == 200) {
					$.each(response.data.list, function () {
						// 성별
						this.gender = this.gender == '1' ? '남' : '여';
						// 권한
						this.auth = this.auth == 'A' ? '관리자' : '사용자';
						// 가입일
						this.joinDate = converter.date.dateTime.toString(new Date(this.joinDate), '-');
						// 생년월일
						this.birth = converter.birth.addPattern(this.birth, '-');
						// 핸드폰번호
						this.phone = converter.phone.addPattern(this.phone, '-');
					});
					
					this.itemList = response.data.list;
				}
			});
		},
		data () {
			return {
				itemList : [],
			}	
		}
	});
	

	// 등록 & 수정 & 삭제 Handler
	new Vue({
		el		: '#modalApp',
		methods : {
			save : function () {
				
				var csrfToken 	= '${_csrf.token}';
				var userId 	= memberId
				var userName 	= memberName

				// validation 체크할 항목 리스트
				var checkArray = [
					{ name : '아이디', 	tag : 'userId', isEmpty : false },
					{ name : '이름', 	tag : 'userName', isEmpty : false}
				];
				
				var isValidation = validation.common(checkArray);
				
				if (isValidation) {
					return false;
				}

				var saveType = 'I';
				var saveText = '등록';
				var itemIdx = $('#itemIdx').val();
				if (itemIdx) {
					saveType 	= 'U';
					saveText 	= '수정';
				}
				
				param = new URLSearchParams();
				param.append('type'		, saveType);
				param.append('itemIdx'	, itemIdx);
				param.append('itemName'	, itemName);
				param.append('itemCode'	, itemCode);
				param.append('itemType'	, $('#itemType').val());
				
				// ajax 요청
				if (confirm(saveText + ' 하시겠습니까?')) {
					axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken;
					axios.post('/houseHoldItem/merge', param).then(response => {
						if (response.status == 200) {
							// 알림 호출
							alert(saveText + '이 완료되었습니다.');
							// 목록 호출
							itemApp.list();
							// 팝업 닫기
							$('#codeCloseBtn').click();
							
						} else {
							alert(saveText + ' 실패하였습니다.');
						}
					});
				}
			},
			upd : function () {
				
			},
			del : function () {
				
				param = new URLSearchParams();
				param.append('type'		, 'D');
				param.append('itemIdx'	, $('#itemIdx').val());
				
				// ajax 요청
				if (confirm('삭제하시겠습니까?')) {
					axios.defaults.headers.common['X-CSRF-TOKEN'] = '${_csrf.token}';
					axios.post('/houseHoldItem/merge', param).then(response => {
						if (response.status == 200) {
							// 알림 호출
							alert('삭제가 완료되었습니다.');
							// 목록 호출
							itemApp.list();
							// 팝업 닫기
							$('#codeCloseBtn').click();
						}
					});
				}
				
			}
		}
	});
});

</script>

<div>
<!-- 	<div class="btn-panel fr"> -->
<!-- 		<button type="button" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#codeAddModal">코드 등록</button> -->
<!-- 	</div> -->
</div>

<div class="row" id="userList">
	<div class="col-md-12">
		<div class="content-panel">
			<table class="table table-striped table-advance table-hover">
				<thead>
					<tr>
						<th class="tc">번호</th>
						<th class="tc">아이디</th>
						<th class="tc">이름</th>
						<th class="tc">생년월일</th>
						<th class="tc">성별</th>
						<th class="tc">핸드폰번호</th>
						<th class="tc">권한</th>
						<th class="tc">회원가입일</th>
					</tr>
				</thead>	
				<tbody>
					<tr v-for="(item, index) in itemList" v-on:click="detail(item.itemIdx)" data-toggle="modal" data-target="#codeAddModal">
						<td class="tc">{{ (index + 1) 			}}</td>
						<td class="tl">{{ item.id				}}</td>
						<td class="tc">{{ item.name				}}</td>
						<td class="tc">{{ item.birth			}}</td>
						<td class="tc">{{ item.gender			}}</td>
						<td class="tc">{{ item.phone			}}</td>
						<td class="tc">{{ item.auth				}}</td>
						<td class="tc">{{ item.joinDate			}}</td>
					</tr>
				</tbody>		
			</table>
		</div>
	</div>
</div>

<div id="modalApp">

	<!-- 등록 modal -->
	<div class="modal fade" id="codeAddModal" tabindex="-1" role="dialog" aria-labelledby="codeAddModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="width:350px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	                <h4 class="modal-title" id="codeAddTitle">코드 등록</h4>
				</div>
				<div class="modal-body">
					<table class="table">
						<tbody>
							<tr>
								<th>아이디</th>
								<td>
									<input type="text" id="userId" readOnly/></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" id="userName" readOnly/></td>
							</tr>
							<tr>
								<th>권한</th>
								<td>
									<select id="itemType">
										<option value="A">관리자</option>
										<option value="U">사용자</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sm btn-default" id="codeCloseBtn" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-sm btn-primary" id="codeDeleteBtn"  v-on:click="del()">삭제</button>
					<button type="button" class="btn btn-sm btn-primary" id="codeInsertBtn"  v-on:click="save()">저장</button>
				</div>
			</div>
		</div>
	</div>
	
</div>
