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
	           <form method="POST" action="${pageContext.request.contextPath}/mypage/updateAddress.do">
	           <input type="text" id="detailAddress" value="${address.detailAddress }" placeholder="나머지 주소를 입력해주세요" required/>
	           <br />
	           <span>받으실 분</span>
	           <br />
	           <input type="text" value="${address.receiver }" placeholder="이름을 입력해주세요" required/>
	           <br />
	           <span>휴대폰</span>
	           <br />
	           <input type="text" value="${address.phone }" placeholder="번호를 입력해주세요" required/>
	           <br />
	          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	           <button type="submit" id="submit-btn">등록</button>
	           </form>
	         
	            <br/>
    </c:if>
   
	<c:if test="${address.defaultAddress eq 'X'.charAt(0)}">
		          <td>${address.zipCode} ${address.address} ${address.detailAddress}</td>
	           <form method="POST" action="${pageContext.request.contextPath}/mypage/updateAddress.do">
	           <input type="text" id="detailAddress" value="${address.detailAddress }" placeholder="나머지 주소를 입력해주세요" required/>
	           <span>받으실 분</span>
	           <input type="text" value="${address.receiver }" placeholder="이름을 입력해주세요" required/>
	           <span>휴대폰</span>
	           <input type="text" value="${address.phone }" placeholder="번호를 입력해주세요" required/>
	           <button type="submit" id="submit-btn">등록</button>
	           </form>
	         
	            <br/>
	</c:if>
	
	
    


<script>







</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>