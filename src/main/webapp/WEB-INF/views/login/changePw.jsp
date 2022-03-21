<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마켓" name="title"/>
</jsp:include>
<meta charset="UTF-8">
<style>
.findSuccess_wrapper{
    min-width: 1050px;
    padding: 50px 0;
    background-color: white;
}
.findSuccess{
	max-width: 400px;
    padding: 0px 30px 30px;
    margin: auto;
    position: relative;
    background-color: white;
}
.tit p {
    padding-bottom: 30px;
    font-weight: 500;
    font-size: 28px;
    text-align: center;
}
.new_pw_div form{
padding: 24px 20px;
}
.new_pw_div label{
    display: inline-block;
    padding: 8px 0 11px;
    font-size: 14px;
    font-weight: 500;
    line-height: 19px;
    color: #333;
}
.new_pw_div input{
	width: 100%;
    height: 46px;
    padding: 0 11px 1px 15px;
    border-radius: 4px;
    border: 1px solid #ddd;
    font-weight: 400;
    font-size: 16px;
    line-height: 1.5;
    color: #333;
    outline: none;
    position: relative;
}
.new_pw1 i{
    position: absolute;
    right: 70px;
    color: gray;
    bottom: 255px;
    font-size: 15px;
}
.new_pw2 i{
	    position: absolute;
    right: 70px;
    color: gray;
    bottom: 173px;
    font-size: 15px;
}
.submit_btn{
	display: block;
    padding: 0 10px;
    text-align: center;
    overflow: hidden;
    width: 100%;
    height: 52px;
    border-radius: 4px;
    color: #fff;
    border: 0 none;
    background-color: #ddd;
    margin-top: 50px;
}
.submit_btn.on{
	background-color: #5f0080;
}
</style>
    <div class="findSuccess_wrapper">
    	<div class="findSuccess">
	    	<div class="tit">
	    		<p>비밀번호 재설정</p>
	    	</div>
	    	<div class="new_pw_div">
	    		<form id="changePw">
	    			<div class="new_pw1">
	    				<label for="">새 비밀번호 등록</label>
	    				<input type="password" name="password" id="pwd1" placeholder="새 비밀번호를 입력해 주세요 "/>
	    				<i class="fa fa-eye-slash fa-lg"></i>
	    			</div>
	    			<div class="new_pw2">
	    				<label for="">새 비밀번호 확인</label>
	    				<input type="password" name="pwd2" id="pwd2" placeholder="새 비밀번호를 한 번 더 입력해 주세요"/>
	    				<i class="fa fa-eye-slash fa-lg"></i>
	    			</div>
		    		<input id="token" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		    		<input type="hidden" name="id" id="id" value="${member.id}"/>
	    			<button disabled type="submit" class="submit_btn">확인</button>
	    		</form>
	    	</div>
    	</div>	
    </div>
<script>
$(changePw).submit((e) => {
	e.preventDefault();
	
	const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const headers = {};
    headers[csrfHeader] = csrfToken;
    
    const id ="${member.id}";
	const password = $("#pwd1").val();
	const password2 = $("#pwd2").val();
	
	// 비밀번호	
	if(! /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,15}$/.test(password)){
        alert("비밀번호는 숫자와 영문이 포함된 8~15자리입니다");
		$("#pwd1").focus();
		return false;
    }
	// 비밀번호 일치 확인
	if(password != password2){
    	alert("비밀번호가 일치하지 않습니다.");
		$("#pwd2").focus();
		return false;
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/login/changePw",
		method: "POST",
		headers : headers,
		data:{
			password,
			id
		},
		success(resp){
			alert("비밀번호 변경 성공! 로그인 페이지로 이동합니다.");
			location.href = "${pageContext.request.contextPath}/login/login";
		},
		error: console.log
	});
});
</script>
<script>
$('#pwd1').on('input', checkInput);
$('#pwd2').on('input', checkInput);
// input 입력 시에 checkInput 함수실행
function checkInput() {
	  var pwd1Check = $('#pwd1').val();   // idCheck 변수
	  var pwd2Check = $('#pwd2').val();   // idCheck 변수
	  
	  var checkSubmit = $('.submit_btn');
	
	  if (pwd1Check === '' || pwd2Check === '') {
	    // 기본 로그인 버튼 색상
	    checkSubmit.removeClass('on');
	  }
	  else {
	    // ID 비밀번호 입력 시에 로그인 버튼 배경색 변경
	    checkSubmit.addClass('on');
	    checkSubmit.prop("disabled", false);
	  }
  
}
$(".new_pw1 i").on('click', function(){
	 $('#pwd1').toggleClass('active');
     if($('#pwd1').hasClass('active')){
         $(this).attr('class',"fa fa-eye fa-lg")
         .prev('#pwd1').attr('type',"text");
     }else{
         $(this).attr('class',"fa fa-eye-slash fa-lg")
         .prev('#pwd1').attr('type','password');
     }
});
$(".new_pw2 i").on('click', function(){
	 $('#pwd2').toggleClass('active');
    if($('#pwd2').hasClass('active')){
        $(this).attr('class',"fa fa-eye fa-lg")
        .prev('#pwd2').attr('type',"text");
    }else{
        $(this).attr('class',"fa fa-eye-slash fa-lg")
        .prev('#pwd2').attr('type','password');
    }
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>