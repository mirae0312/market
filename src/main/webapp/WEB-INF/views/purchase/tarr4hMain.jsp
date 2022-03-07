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
	
	
	<p>쿠폰 생성 테스트</p>
	<span>할인율</span><input type="text" name="" id="discountRate" />
	<br />
	<span>만료일자</span><input type="date" name="" id="expiration" />
	<br />
	<span>생성하기</span><input type="button" value="createCoupon" id="createCoupon"/>
	<br />
	<span>발급된쿠폰번호</span><input type="text" name="" id="couponCode" />
	
	
	<p>카테고리별 상품 리스트 화면</p>
	<a href="${pageContext.request.contextPath }/product/productList?largeCategory=카테고리1&smallCategory=소분류1">상품 리스트 화면</a>
	
	<p>장바구니 화면</p>
	<a href="${pageContext.request.contextPath }/product/cart/myCart">장바구니화면</a>
	
<script>
	$("#createCoupon").click((e) => {
		console.log("쿠폰 생성");
		$.ajax({
			url: '${pageContext.request.contextPath}/purchase/createCoupon',
			data : {
				discountRate: $("#discountRate").val(),
				expiration: $("#expiration").val()
			},
			success(res){
				$("#couponCode").val(res);
			},
			error: console.log
		});
	});


</script>
</body>
</html>