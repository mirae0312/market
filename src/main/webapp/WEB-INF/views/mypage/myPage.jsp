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
	<span>내 쿠폰</span>
	<br />
	<c:forEach var="list" items="${couponList }">
        <tr>
            <td><span>쿠폰 코드 </span>${list.code }</td>
            <td><span>할인률 </span>${list.discountRate }</td>
            <td><span>만료일자 </span><fmt:formatDate value="${list.expiration}" pattern="yyyy/MM/dd일"/></td>
            <br/>
        </tr>
    </c:forEach>


<script>





$("#useCoupon").click((e) => {
		console.log("쿠폰 등록");
		$.ajax({
			url: '${pageContext.request.contextPath}/mypage/useCoupon',
			data : {
				writeCoupon: $("#writeCoupon").val()
			},
			success(res){
				if(res == 2){
					alert("쿠폰 등록 성공!");
				}
				else if(res == 1){
					alert("유효기간이 만료된 쿠폰입니다.");
				}
				else if(res == 0){
					alert("쿠폰 등록 실패!");
				}
			},
			error: console.log
		});
});


</script>
</body>
</html>