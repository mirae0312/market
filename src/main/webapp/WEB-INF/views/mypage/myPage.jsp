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
	
	<span>-----------------------------------------------</span>
	<br />
	<span>내 쿠폰</span>
	<br />
	

	
	<c:forEach var="list" items="${couponList }">
        <tr>
            <%-- 유효기간 남아있는 쿠폰들 --%>
        	<c:if test="${nowDate < list.expiration}">
	            <td><span>쿠폰 코드 </span>${list.code }</td>
	            <td><span>할인률 </span>${list.discountRate }%</td>
	            <td><span>만료일자 </span><fmt:formatDate value="${list.expiration}" pattern="yyyy/MM/dd일"/></td>
	            <br/>
            </c:if>
            
            <%-- 만료된 쿠폰들 --%>
           	<div style="color:gray">
	            <c:if test="${nowDate > list.expiration}"> 
		            <td><span>쿠폰 코드 </span>${list.code }</td>
		            <td><span>할인률 </span>${list.discountRate }%</td>
		            <td><span>만료일자 </span><fmt:formatDate value="${list.expiration}" pattern="yyyy/MM/dd일"/></td>
		            <td><span>만료된 쿠폰입니다. </span></td>
		            <br/>
	            </c:if>
         	</div>
        </tr>
    </c:forEach>
    
    <span>-----------------------------------------------</span>
    <p>개인 정보 수정</p>
    <span>아이디</span><input type="text" name="" id="" value="${userId}"/>
    <br />
    <span>비밀번호</span><input type="text" name="" id="changePw"/>
    <br /> 
    <input type="button" value="확인" id="changePwBtn"/>


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
					location.href='${pageContext.request.contextPath}/mypage/myPage';
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

$("#changePwBtn").click((e) => {
	console.log("비밀번호 변경");
	$.ajax({
		url: '${pageContext.request.contextPath}/mypage/changePw',
		data : {
			changePw: $("#changePw").val()
		},
		success(res){
			
		},
		error: console.log
	});
});

</script>
</body>
</html>