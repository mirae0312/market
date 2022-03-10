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
<style>
.find_pwd{
    padding: 50px 0;
    background-color: white;
}
.find_pwd_title{
    padding-bottom: 30px;
    font-weight: 500;
    font-size: 28px;
    text-align: center;
}
.find_pwd_container{
    max-width: 400px;
    padding: 0 10px 6px 10px;
    margin: auto;
    position: relative;
    background-color: white;
}
.select_div{
    background-color: white;
    padding: 0 15px 0 15px;
    margin: 0;
    box-shadow: inset 0 -0.5px 0 0 #ddd;
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-box-flex-wrap: nowrap;
    -webkit-flex-wrap: nowrap;
    -ms-flex-wrap: nowrap;
    flex-wrap: nowrap;
    text-align: center;
}
.phone_btn{
    display: block;
    -webkit-box-flex: 1;
    -webkit-flex-grow: 1;
    -ms-flex-positive: 1;
    flex-grow: 1;
    position: relative;
    height: 48px;
    font-weight: 500;
    font-size: 16px;
    color: #5f0080;
    line-height: 18px;
    box-shadow: inset 0px -2px 0px 0px #5f0080;
}
button, select {
    text-transform: none;
}
button {
    overflow: visible;
    background-color: transparent;
    border: none;
}
.findFrm{
    padding: 24px 20px;
}
.name_div{
    padding-bottom: 12px;
}
.name_label{
    display: inline-block;
    padding: 8px 0 11px;
    font-size: 14px;
    font-weight: 500;
    line-height: 19px;
    color: #333;
}
.form_name{
    width: 100%;
    height: 46px;
    padding: 0 11px 1px 15px;
    border: none;
    border-radius: 4px;
    font-weight: 400;
    font-size: 16px;
    line-height: 1.5;
    color: #333;
    outline: none;
}
.submit_btn:disabled{
    background-color: #ddd;
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
    background-color: #5f0080;
    border: 0 none;
}
.submit_btn.on{
	background-color: #5f0080;
}
.phone_div{
    padding-bottom: 12px;
}
.phone_label{
    display: inline-block;
    padding: 8px 0 11px;
    font-size: 14px;
    font-weight: 500;
    line-height: 19px;
    color: #333;
}
#name, #phone{
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
}
.email_btn{
display: block;
    -webkit-box-flex: 1;
    -webkit-flex-grow: 1;
    -ms-flex-positive: 1;
    flex-grow: 1;
    position: relative;
    height: 48px;
    font-weight: 400;
    font-size: 16px;
    color: #666;
    line-height: 18px;
}
.submit_btn{
margin-top: 18px;
}
</style>
</head>

<body>
    <div class="find_pwd">
        <div class="find_pwd_title">비밀번호 찾기</div>
        <div class="find_pwd_container">
            <div class="select_div">
                <button selected="" type="button" class="phone_btn">
                    휴대폰 인증</button>
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
                        	<input type="tel" id="phone" name="phone" value=""
                                placeholder="휴대폰 번호를 입력해 주세요" class="phone_input">
                        </div>
                </div>
                <button class="submit_btn" type="submit" disabled=""
                        radius="4"><span class="get_number">인증번호 받기</span></button>
                </form>
        </div>
    </div>
<script>
$('#name').on('input', checkInput);
$('#phone').on('input', checkInput);

// input 입력 시에 checkInput 함수실행
function checkInput() {
  var nameCheck = $('#name').val();   // idCheck 변수
  var phoneCheck = $('#phone').val();   // idCheck 변수
  var checkSubmit = $('.submit_btn');

  if (nameCheck === '' || phoneCheck === '') {
    // 기본 로그인 버튼 색상
    checkSubmit.removeClass('on');
  } else {
    // ID 비밀번호 입력 시에 로그인 버튼 배경색 변경
    checkSubmit.addClass('on');
  }
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>