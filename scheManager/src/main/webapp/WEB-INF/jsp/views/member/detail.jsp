<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.join-div{margin:0 auto;float:none;}
[name="gender"]{width:70px;}
</style>

<script type="text/javascript">
 $(document).ready(function(){
	 $('#email').val(memberId);
	 $('#name').val(memberName);
	 $('#birth').val(memberBirth);
	 $('#gender').val(memberGender);

	 $('#phone').val(memberPhone);
	 
	 $('#email').keyup(function () {
		 var v = $(this).val();
		 $(this).val(v.replace(/ /gi, ''));
		 
	 });
	 
	 
	 $('#currentPw').keyup(function () {
		 var v = $(this).val();
		 $(this).val(v.replace(/ /gi, ''));
		 
	 });
	 
	 $('#newPw').keyup(function () {
		 var v = $(this).val();
		 $(this).val(v.replace(/ /gi, ''));
		 
	 });
	 
	 $('#checkPw').keyup(function () {
		 var v = $(this).val();
		 $(this).val(v.replace(/ /gi, ''));
		 
	 });
	 
	 $('#name').keyup(function () {
		 var v = $(this).val();
		 $(this).val(v.replace(/ /gi, ''));
		 
	 });
	 
	 $('#birth').keyup(function () {
		 var v = $(this).val();
		 $(this).val(v.replace(/ /gi, ''));
		 $(this).val(v.replace(/[^a-z0-9]/gi, ''));
		 
	 });
	 
	 $('#phone').keyup(function () {
		 var v = $(this).val();
		 $(this).val(v.replace(/ /gi, ''));
		 $(this).val(v.replace(/[^a-z0-9]/gi, ''));
		 
	 });
	 
	 $('#create').unbind('click').click(function() { 
		 var sEmail = $('#email').val();
		 
		 if ($.trim(sEmail).length == 0) {
		 	alert('이메일을 입력해 주세요');
		 	return false;
		 }
		 
		 // 아이디 중복확인
		 if(memberId == $('#email').val()) {
		 } else {
			 if (getId()) {
				 return false;
			 }
		 }
		 
		 // 현재 비밀번호 체크
		 if($('#currentPw').val() == "") {
			 alert('현재 비밀번호를 입력해 주세요');
			 return false;
		 }
		 
		 // 현재 비밀번호 중복확인
		 if(memberPw != $('#currentPw').val()) {
			 alert('현재 비밀번호가 틀립니다');
	 		return false;
		 }
		 
		 if(memberPw == $('#newPw').val()) {
			 alert('변경할 비밀번호는 현재 비밀번호와 같을 수 없습니다');
			 return false;
		 }
			 
		 if(!chkPwd( $.trim($('#newPw').val()))){

			   $('#newPw').val('');

			   $('#newPw').focus();

			   return false;

			}
		 
		 if($('#newPw').val() != $('#checkPw').val()){
			 alert("비밀번호가 다릅니다");
			 $('#checkPw').focus();
			  return false;
		 } 
		 
		 $('#name').val($('#name').val().trim());
		  if(!chkName($('#name').val())) {
		   $('#name').focus();
		   return false;
		  }
		 
		  $('#birth').val($('#birth').val().trim());
		  if(!birth($('#birth').val())) {
			  $('#birth').focus();
			  return false;
		  }
		  
		  $('#phone').val($('#phone').val().trim());
		  if(!cellPhone($('#phone').val())) {
			   $('#phone').focus();
			   return false;
			  }
		  
			 if($('#newPw').val().length == 0) {
				 $('#newPw').val(memberPw);
				 $('#checkPw').val(memberPw);
			 }

		 alert('개인정보수정 성공');
 		 $('#form').submit();
 		 location.href = '/notiles/login';
	 });
 });
 
 function validateEmail(sEmail) {
	 var filter = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	 	if (filter.test(sEmail)) {
			 return true;
		} else {
			 return false;
	 	}
 }
 function chkPwd(str){

	 var pw = str;
	 var num = pw.search(/[0-9]/g);
	 var eng = pw.search(/[a-z]/ig);
	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	 
	 if(pw.length != 0) {
		 
		 if(pw.length < 8 || pw.length > 20){
		  alert("비밀번호는 8자리 ~ 20자리 이내로 입력해주세요.");
		  return false;
		 }
		 
		 if(num < 0 || eng < 0 || spe < 0 ){
		  alert("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
		  return false;
		 }
	 }
	 
	 return true;
 }
 
 function chkName(str) {
  var name = str;
  var reg_name = /^[가-힣]{2,10}$/;
  
  if(name.length == 0) {
		 alert('이름을 입력하세요');
		 return false;
	 }
  
if(!reg_name.test(str)) {
	alert('이름을 확인하세요.(한글 2~10자 이내)');
   return false;
  }
  return true;
 }
 
 function birth(dateStr) {
	 var birth = dateStr;
     var month = Number(dateStr.substr(4,2));
     var day = Number(dateStr.substr(6,2));
     var today = new Date(); // 날자 변수 선언
     var yearNow = today.getFullYear();
 
 
     if(birth.length == 0) {
    	 alert('생년월일을 입력하세요');
    	 return false;
     }
     
     if(birth.length > 8 || birth.length < 8) {
    	 alert('올바른 형식이 아닙니다');
    	 return false;
     }
     
     if (month < 1 || month > 12) { 
          alert("달은 1월부터 12월까지 입력 가능합니다.");
          return false;
     }
    if (day < 1 || day > 31) {
          alert("일은 1일부터 31일까지 입력가능합니다.");
          return false;
     }
     if ((month==4 || month==6 || month==9 || month==11) && day==31) {
          alert(month+"월은 31일이 존재하지 않습니다.");
          return false;
     }
     if (month == 2) {
          var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
          if (day>29 || (day==29 && !isleap)) {
               alert(year + "년 2월은  " + day + "일이 없습니다.");
               return false;
          }
     }
     return true;
}
 function cellPhone(phone) {
	var phone = phone;
	var regExp = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	
	if(phone.length > 0) {
	
		if(phone.length != 11) {
			 alert('핸드폰번호 형식이 맞지 않습니다');
			 return false;
		}
		if ( !regExp.test(phone) ) {
		     alert("잘못된 휴대폰 번호입니다. 숫자만 입력하세요.");
		     return false;
		}
		
		return true;
	}
 }
 
function getId(){
	// 아이디 중복확인
	var reqParam = {
		name	: '아이디',
		tag		: 'email',
		data	: {
			keyword						: $('#email').val(),
			'${_csrf.parameterName}' 	: '${_csrf.token}'
		}
	};
	
	return validation.overlap('/join/getId', reqParam);
}
</script> 
<div class="col-lg-6 join-div">
	<form action="/join/update" method="POST" id="form">
		<input type ="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<table class="table">
			<tr>
				<th><label for="email">이메일</label></th>
				<td><input type="text" class="form-control" name="id" id="email" size="50" placeholder="Enter email" readOnly></td>	
			</tr>
			<tr>
				<th><label for="currentPw">현재 비밀번호</label></th>
				<td><input type="password" class="form-control" id="currentPw" size="20" placeholder="Password">※8-20자의 영문 숫자 특수문자 혼합</td>
			</tr>
			<tr>
				<th><label for="newPw">변경 비밀번호</label></th>
				<td><input type="password" class="form-control" name="password" id="newPw" size="20" placeholder="Password">※8-20자의 영문 숫자 특수문자 혼합</td>
			</tr>
			<tr>
				<th><label for="checkPw">비밀번호 확인</label></th>
				<td><input type="password" class="form-control" id="checkPw" size="20" placeholder="Password">※비밀번호 재입력</td>
			</tr>
			<tr>
				<th><label for="name">이름</label></th>
				<td><input type="text" class="form-control" name="name" id="name" placeholder="이름"></td>
			</tr>
			<tr>
				<th><label for="birth">생년월일</label></th>
				<td><input type="text" class="form-control" name="birth" id="birth" size="6" placeholder="생년월일"></td>
			</tr>
			<tr>
				<th><label for=gender>성별</label></th>
				<td>
					<select class="form-control" id="gender" name="gender">
						<option value="1">남</option>
						<option value="2">여</option>
					</select>
	  			</td>
			</tr>
			<tr>
				<th><label for="phone">휴대폰</label></th>
				<td>
					<input type="text" class="form-control" id="phone" size="11" name="phone" placeholder="휴대폰번호">
				</td>
			</tr>
		</table>
	</form>
	<button class="btn btn-info center-block" type="button" id="create">수정</button>	
</div>
