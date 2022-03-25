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

	<h1>배송지 수정</h1>
	
	<c:if test="${address.defaultAddress eq 'D'.charAt(0)}">
        	   <div style="color:gray">
	           	<td><span>기본 배송지</span></td>
	           </div>
	           <td>${address.zipCode} ${address.address} ${address.detailAddress}</td>
	           <td>${address.deliveryType }</td>        	
	            <br/>
    </c:if>
   
	<c:if test="${address.defaultAddress eq 'X'.charAt(0)}">
		           <td>${address.zipCode} ${address.address} ${address.detailAddress}</td>
	           	   <td>${address.deliveryType }</td>
	           	   <td><input type="button" value="수정" class="updateAddr" onclick="countIndex(${status.index})" /></td>
	           	   
		            <br/>
	</c:if>
	<p>회원 쿠폰 등록</p>
	<span>쿠폰입력란</span><input type="text" name="" id="writeCoupon" />
	<br />
	<span>쿠폰등록</span><input type="button" value="useCoupon" id="useCoupon"/>
	<br />
	
	<span>-----------------------------------------------</span>
	<br />
	<span>내 쿠폰</span>
	<br />
	
    


<script>







</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>