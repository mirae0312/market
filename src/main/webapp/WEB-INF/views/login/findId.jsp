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
<style>
.code_num .count_down {
    position: absolute;
    left: 216px;
    top: 21px;
    width: 100px;
    font-size: 14px;
    color: #b3130b;
    line-height: 20px;
    text-align: right;
    letter-spacing: -.5px;
}

.code_num{
	position: relative;
	padding-top: 10px;
	/* display:none; */
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login/findId.css" />
<div class="find_id">
	<div class="find_id_title">아이디 찾기</div>
	<div class="find_id_container">
		<div class="select_div">
			<button selected="" type="button" class="phone_btn">휴대폰 인증</button>
			<button type="button" class="email_btn">이메일 인증</button>
		</div>
		<form class="findFrm">
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
					<input type="tel" id="phone" name="phone" value="" pattern="[0-9]*"
						maxlength="11" placeholder="휴대폰 번호를 입력해 주세요" class="phone_input">
				</div>
				<button class="submit_btn" type="submit" disabled="" radius="4">
					<span class="get_number">인증번호 받기</span>
				</button>
			</div>
			
			<div class="email_div">
				<label for="email" class="email_label">이메일</label>
				<div class="email_input_div">
					<input type="email" id="email" name="email" value=""
						placeholder="이메일을 입력해 주세요" class="email_input">
				</div>
				<button class="email_submit_btn" type="submit" disabled=""
					radius="4">
					<span class="get_number">확인</span>
				</button>
			</div>
		</form>
	</div>
</div>
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
	  }
	  
	}
</script>
<script>
$(".phone_btn").click((e) => {
	const phone_div = $(".phone_div");
	const email_div = $(".email_div");
	const checkType = "IP";
	
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