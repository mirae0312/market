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
	           <form method="POST" name="updateAd" >
	           <input type="text" id="detailAddress" name="detailAddress" value="${address.detailAddress }" placeholder="나머지 주소를 입력해주세요" required/>
	           <br />
	           <span>받으실 분</span>
	           <br />
	           <input type="text" id="receiver" name="receiver" value="${address.receiver }" placeholder="이름을 입력해주세요" required/>
	           <br />
	           <span>휴대폰</span>
	           <br />
	           <input type="text" id="phone" name="phone" value="${address.phone }" placeholder="번호를 입력해주세요" required/>
	           <br />
	           
	            <input type="hidden" name="zipCode" value="${address.zipCode}" />
	            <input type="hidden" name="address" value="${address.address}" />
	         
	           <button type="button" class="update-Add" >등록</button>
	           </form>
	         
	            <br/>
    </c:if>
   
	<c:if test="${address.defaultAddress eq 'X'.charAt(0)}">
		          <td>${address.zipCode} ${address.address} ${address.detailAddress}</td>
	           <form method="POST" class="updateAd">
	           <input type="text" id="detailAddress" name="detailAddress" value="${address.detailAddress }" placeholder="나머지 주소를 입력해주세요" required/>
	           <br />
	           <span>받으실 분</span>
	           <br />
	           <input type="text" id="receiver" name="receiver" value="${address.receiver }" placeholder="이름을 입력해주세요" required/>
	           <br />
	           <span>휴대폰</span>
	           <br />
	           <input type="text" id="phone" name="phone" value="${address.phone }" placeholder="번호를 입력해주세요" required/>
	           <br />
	            <input type="checkbox" name="checkAddress" id="" data-check-val="${address.defaultAddress}" />
                <br />
	         
	           <input type="hidden" name="zipCode" value="${address.zipCode}" />
	            <input type="hidden" name="address" value="${address.address}" />
	           <button type="button" class="update-Add">등록</button>
	           </form>
	         
	            <br/>
	</c:if>
	
	
    


<script>



const csrfHeader = "${_csrf.headerName}";
const csrfToken = "${_csrf.token}";
const headers = {};
headers[csrfHeader] = csrfToken;

$(".update-Add").click((e) => {

	var form = $("#updateAd").serialize();
	
	$.ajax({
		url: '${pageContext.request.contextPath}/mypage/updateAddress.do',
		method: "POST",
		headers : headers,
		dataType : "json",
		data : JSON.stringify(form),
		contentType : "application/json; charset=UTF-8",
		success(res){
			
		
		
			
		},
		error: console.log
	});
	
});







</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>