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
.tit{
    padding-top: 30px;
    font-weight: 500;
    font-size: 17px;
    line-height: 23px;
}
.member-info{
    padding: 12px 0px;
}
.button_div{
    margin-top: 60px;
}
.findPwd_btn{
	display: block;
    padding: 0px 10px;
    text-align: center;
    overflow: hidden;
    width: 100%;
    height: 52px;
    margin-bottom: 10px;
    border-radius: 6px;
    color: rgb(95, 0, 128);
    background-color: rgb(255, 255, 255);
    border: 1px solid rgb(95, 0, 128);
    cursor: pointer;
}
.login_btn{
	cursor: pointer;
    display: block;
    padding: 0px 10px;
    text-align: center;
    overflow: hidden;
    width: 100%;
    height: 52px;
    border-radius: 6px;
    color: rgb(255, 255, 255);
    background-color: rgb(95, 0, 128);
    border: 0px none;
}
</style>
    <div class="findSuccess_wrapper">
    	<div class="findSuccess">
	    	<div class="tit">
	    		<p>고객님의 마켓컬리 계정을 찾았습니다.</p>
	    		<p>아이디 확인 후 로그인해 주세요.</p>
	    	</div>
	    	<div class="member-info">
	    		<img class="" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CiAgICA8ZyBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPgogICAgICAgIDxjaXJjbGUgZmlsbD0iI0Y1RjVGNSIgY3g9IjIwIiBjeT0iMjAiIHI9IjIwIi8+CiAgICAgICAgPHBhdGggZD0iTTIwIDE5YzQuNjUzIDAgOC41IDMuNDc2IDguNSA3LjcyIDAgLjQzLS4zNDYuNzgtLjc3My43OEgxMi4yNzNhLjc3Ni43NzYgMCAwIDEtLjc3My0uNzhjMC00LjI4NSAzLjgyNC03LjcyIDguNS03Ljcyem0wLTguNWEzLjQgMy40IDAgMSAxIDAgNi44IDMuNCAzLjQgMCAwIDEgMC02Ljh6IiBzdHJva2U9IiNDQ0MiIGZpbGw9IiNDQ0MiLz4KICAgIDwvZz4KPC9zdmc+Cg==" alt="정보보기">
	    		<div class="member-id">${member.id}</div>
	    		<div class="regDate">가입일
	    		<fmt:formatDate value="${member.regDate}" pattern="yyyy.MM.dd"/><br />
	    		</div>
	    	</div>
	    	<div class="button_div">
	    		<button class="findPwd_btn" onClick="location.href='${pageContext.request.contextPath}/login/findPwd'">비밀번호 찾기</button>
	    		<button class="login_btn" onClick="location.href='${pageContext.request.contextPath}/login/login'">로그인</button>
	    	</div>
    	</div>	
    </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>