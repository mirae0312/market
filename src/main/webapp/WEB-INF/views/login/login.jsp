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
    <title>Login</title>
<!-- login css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/login.css" /> 
 
    <div id="main">
        <div id="content">
            <div class="section_login">
                <h3 class="tit_login">로그인</h3>
                <div class="write_form">
                    <div class="write_view login_view">
                        <form method="post" name="form" id="form" action="">
                            <input type="text" name="username" size="20" tabindex="1" value="" placeholder="아이디를 입력해주세요">
                            <input type="password" name="password" size="20" tabindex="2" placeholder="비밀번호를 입력해주세요">
                            
                       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                       
                            
                            <div class="checkbox_save">
                                <label class="label_checkbox">
                            		<input type="checkbox" id="keep_login" name="remember-me" value="y">
                                    로그인 유지
                                </label>

                                <div class="login_search">
                                    <a class="link" href="${pageContext.request.contextPath}/login/findId">
                                        아이디 찾기
                                    </a>
                                    <span class="bar"></span>
                                    <a class="link" href="${pageContext.request.contextPath}/login/findPwd">
                                        비밀번호 찾기
                                    </a>
                                </div>
                            </div>
                            <button class="btn_type1" type="submit">
                                <span class="txt_type">로그인</span>
                            </button>
                        </form>                    
					    
                        <a class="btn_type2 btn_member" href="${pageContext.request.contextPath}/join/join">
                            <span class="txt_type">회원가입</span>
                        </a>
                        <div class="sns-enroll">
                        	<div class="kakao">
			                 	<a href="#"><svg width="48" height="48" viewBox="0 0 48 48" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><path fill="#FFEB00" d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path><path fill="#3C2929" d="M24 11.277c8.284 0 15 5.306 15 11.85 0 6.545-6.716 11.85-15 11.85-.92 0-1.822-.066-2.697-.191l-6.081 4.105a.43.43 0 0 1-.674-.476l1.414-5.282C11.777 31.031 9 27.335 9 23.127c0-6.544 6.716-11.85 15-11.85zm6.22 8.407c-.416 0-.718.297-.718.707v5.939c0 .41.289.686.718.686.41 0 .718-.295.718-.686v-1.932l.515-.526 1.885 2.57c.277.374.426.54.691.568.037.003.075.005.112.005.154 0 .66-.04.716-.563.038-.293-.137-.52-.348-.796l-2.043-2.675 1.727-1.743.176-.196c.234-.26.353-.39.353-.587.009-.422-.34-.652-.687-.661-.274 0-.457.15-.57.262l-2.528 2.634v-2.3c0-.422-.288-.706-.717-.706zm-9.364 0c-.56 0-.918.432-1.067.837l-2.083 5.517a.84.84 0 0 0-.065.315c0 .372.31.663.706.663.359 0 .578-.162.69-.51l.321-.97h2.999l.313.982c.111.335.34.498.7.498.367 0 .655-.273.655-.62 0-.056-.017-.196-.081-.369l-2.019-5.508c-.187-.53-.577-.835-1.069-.835zm-2.92.064h-4.452c-.417 0-.642.337-.642.654 0 .3.168.652.642.652h1.51v5.21c0 .464.274.752.716.752.443 0 .718-.288.718-.751v-5.21h1.508c.474 0 .643-.352.643-.653 0-.317-.225-.654-.643-.654zm7.554-.064c-.442 0-.717.287-.717.75v5.707c0 .497.28.794.75.794h2.674c.434 0 .677-.321.686-.627a.642.642 0 0 0-.17-.479c-.122-.13-.3-.2-.516-.2h-1.99v-5.195c0-.463-.274-.75-.717-.75zm-4.628 1.306l.008.01 1.083 3.265h-2.192L20.842 21a.015.015 0 0 1 .028 0z"></path></g></svg></a>
                        	</div>
                        	<div class="naver">
                        		<a href="#"><svg width="48" height="48" viewBox="0 0 48 48" preserveAspectRatio="xMidYMid meet"><g fill="none" fill-rule="evenodd"><path fill="#00C63B" d="M0 24C0 10.745 10.745 0 24 0s24 10.745 24 24-10.745 24-24 24S0 37.255 0 24z"></path><path fill="#FFF" d="M21 25.231V34h-7V15h7l6 8.769V15h7v19h-7l-6-8.769z"></path></g></svg></a>
                        	</div>
                        	<div class="google">
                        		<a href="#"><img src="https://img.icons8.com/fluency/48/000000/google-logo.png"/></a>
                        	</div>
                        </div>
                       
                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
$(".kakao").click((e) => {
	location.href = "https://kauth.kakao.com/oauth/authorize?client_id=2ae5bd0deaf271ba341cbf761624570d&redirect_uri=http://localhost:10000/market/login/kakaoLogin&response_type=code";
	/* const type = "kakao";
	$.ajax({
		url: `${pageContext.request.contextPath}/login/snsLogin/\${type}`,
		method: "GET",
		contentType: 'javascript/jsonp; charset=utf-8',
		dataType: 'jsonp',
		jsonp : "callback",
		success(resp){
			console.log(resp);
		},
		error: console.log
	}); */
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>