<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="tarr4h main link" name="title"/>
</jsp:include>
	<h1>화면 구현 전 작업용 링크연결 페이지</h1>
	
	
	<p>회원 쿠폰 등록</p>
	<span>쿠폰입력란</span><input type="text" name="" id="writeCoupon" />
	<br />
	<span>쿠폰등록</span><input type="button" value="useCoupon" id="useCoupon"/>
	<br />
	<span>발급된쿠폰번호</span><input type="text" name="" id="couponCode" />
	
	
	
	
<script>
	$("#useCoupon").click((e) => {
		console.log("쿠폰 등록");
		$.ajax({
			url: '${pageContext.request.contextPath}/myPage/useCoupon',
			data : {
				writeCoupon: $("#writeCoupon").val()
			},
			success(res){
				alert("성공");
			},
			error: console.log
		});
	});


</script>
</body>
</html>