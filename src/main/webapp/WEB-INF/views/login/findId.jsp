<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마켓" name="title" />
</jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login/findId.css" />
<div class="find_id">
	<div class="find_id_title">아이디 찾기</div>
	<div class="find_id_container">
		<div class="select_div">
			<button selected="" type="button" class="phone_btn">휴대폰 인증</button>
			<button type="button" class="email_btn">이메일 인증</button>
		</div>
		<form class="findFrm" action="${pageContext.request.contextPath}/login/findIdSuccess">
			<div class="name_div">
				<label for="name" class="name_label">이름</label>
				<div class="name_input_div">
					<input type="text" id="name" name="name" value=""
						placeholder="이름을 입력해 주세요" class="name_input">
				</div>
			</div>
			<div class="phone_div">
				<label for="phone" class="phone_label">휴대폰 번호</label>
				<div class="phone_input_div">
					<input type="text" id="phone" name="phone" value="" pattern="[0-9]*"
						maxlength="11" placeholder="휴대폰 번호를 입력해 주세요" class="phone_input">
					<input type="hidden" name="phoneVal" id="phoneVal" value="0" />
				</div>
				<div class="phone_code">
					<label for="code" class="code_label">인증번호</label>
					<div class="code_div">
						<div class="code_input_div">
							<input type="text" id="code" name="code" value=""
								placeholder="인증번호 숫자 6자리" maxlength="6" />
						</div>
						<button class="re_code_btn" type="button">시간 연장</button>
						<p id="countdown" class="count_down"></p>
					</div>
				</div>
				
				<button class="submit_btn" id="phone_confirm_btn" type="button"
					disabled radius="4">
					<span class="get_number">인증번호 받기</span>
				</button>
				<button class="submit_btn" id="final_id_btn" type="submit"
					disabled radius="4">
					<span class="get_number">확인</span>
				</button>
			</div>
			<div class="email_div">
				<label for="email" class="email_label">이메일</label>
				<div class="email_input_div">
					<input type="email" id="email" name="email" value=""
						placeholder="이메일을 입력해 주세요" class="email_input">
				</div>
				<button class="email_submit_btn" type="submit" disabled
					radius="4">
					<span class="get_number">확인</span>
				</button>
			</div>
			<input type="hidden" id="checkType" name="checkType" value="" />
		</form>
	</div>
</div>
<script>
$(".email_submit_btn").click((e) => {
	const name = $("[name=name]").val();
	const email = $("[name=email]").val();

	$("#checkType").val("IE");
	
	$.ajax({
		url: "${pageContext.request.contextPath}/login/certifiedNum",
		data:{
			name,
			email
		},
		success(resp){
			console.log(resp);
		},
		error: console.log
	});
});

$("#phone_confirm_btn").click((e) => {
	e.preventDefault();
	
	const checkType = "IP";
	const button1 = $("#phone_confirm_btn");
	const button2 = $("#final_id_btn");
	const code_div = $(".phone_code");
	
	button1.hide();
	button2.show();
	code_div.show();
	
	const name = $("[name=name]").val();
	const phone = $("[name=phone]").val();
	
	$("[name=name]").prop("readonly", true);
	$("[name=phone]").prop("readonly", true);
	
	//인증번호 타이머
	var count_down = $(".count_down");
	var timer = null;
	var isRunning = false;
	
	count_down.show();
	
	$(".re_code_btn").click((e)=> {
		e.preventDefault();
		$(".submit_btn").addClass('on');
		var leftSec = 60;
		 if (isRunning){ 
			    clearInterval(timer);
			    count_down.html("");
			    startTimer(leftSec, count_down);
			  }else{
			  	startTimer(leftSec, count_down);
			  }
	});
	
	$.ajax({
		url: "${pageContext.request.contextPath}/login/certifiedNum",
		data:{
			checkType,
			name,
			phone
		},
		success(resp){
			console.log(resp);
			const {num} = resp;
			var leftSec = 180;
			
			// 버튼 클릭 시 시간 연장
			  if (isRunning){ 
			    clearInterval(timer);
			    count_down.html("");
			    startTimer(leftSec, count_down);
			  }else{
			  	startTimer(leftSec, count_down);
			  }
			
			$("#final_id_btn").click((e) => {
				const code = $("#code").val();
				
				if(num == code){
					$("#checkType").val("IP");
					alert("핸드폰 인증에 성공하였습니다.");
				}
				else{
					alert("핸드폰 인증 실패");
					return false;
				}
			})
		},
		error: console.log
	});
	function startTimer(count, display) {  
		  var minutes, seconds;
		  timer = setInterval(function () {
		    minutes = parseInt(count / 60, 10);
		    seconds = parseInt(count % 60, 10);

		    minutes = minutes < 10 ? "0" + minutes : minutes;
		    seconds = seconds < 10 ? "0" + seconds : seconds;

		    count_down.html(minutes + ":" + seconds);

		    // 타이머 끝
		    if (--count < 0) {
		      clearInterval(timer);
		      alert("인증시간이 만료되었습니다.");
		      count_down.html("");
		      $(".submit_btn").removeClass('on');
		      $(".submit_btn").attr("disabled", true);
		      isRunning = false;
		    }
		  }, 1000);
		  isRunning = true;
	}
});
</script>
<script>
$('#name').on('input', checkInput);
$('#phone').on('input', checkInput);
$('#email').on('input', checkEmail);
// input 입력 시에 checkInput 함수실행
function checkInput() {
	  var nameCheck = $('#name').val();   // idCheck 변수
	  var phoneCheck = $('#phone').val();   // idCheck 변수
	  
	  var checkSubmit = $('.submit_btn');
	
	  if (nameCheck === '' || phoneCheck === '') {
	    // 기본 로그인 버튼 색상
	    checkSubmit.removeClass('on');
	  }
	  else {
	    // ID 비밀번호 입력 시에 로그인 버튼 배경색 변경
	    checkSubmit.addClass('on');
	    checkSubmit.prop("disabled", false);
	  }
  
}
function checkEmail() {
	  var nameCheck = $('#name').val();   // idCheck 변수
	  var emailCheck = $('#email').val();
	  
	  var checkSubmit = $('.email_submit_btn');

	  if (nameCheck === '' || emailCheck === '') {
	    // 기본 로그인 버튼 색상
	    checkSubmit.removeClass('on');
	  }
	  else {
	    // ID 비밀번호 입력 시에 로그인 버튼 배경색 변경
	    checkSubmit.addClass('on');
	    checkSubmit.prop("disabled", false);
	  }
	  
	}
</script>
<script>
$(".phone_btn").click((e) => {
	const phone_div = $(".phone_div");
	const email_div = $(".email_div");
	changeIP();
	phone_div.show();
	email_div.hide();
	
});


$(".email_btn").click((e) => {
	const checkType = "IE";
	const phone_div = $(".phone_div");
	const email_div = $(".email_div");
	
	changeIE();
	phone_div.hide();
	email_div.show();
});

function changeIP(){
	$('.email_btn').css('color','#666');
	$('.email_btn').css('box-shadow','none');
	$('.phone_btn').css('color','#5f0080');
	$('.phone_btn').css('box-shadow','inset 0px -2px 0px 0px #5f0080');
}

function changeIE(){
	$('.phone_btn').css('color','#666');
	$('.phone_btn').css('box-shadow','none');
	$('.email_btn').css('color','#5f0080');
	$('.email_btn').css('box-shadow','inset 0px -2px 0px 0px #5f0080');
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />