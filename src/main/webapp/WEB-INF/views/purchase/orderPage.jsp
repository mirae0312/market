<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="주문하기" name="title"/>
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기</title>
</head>
<body>
	<h1>주문서</h1>
	
	<table id="orderProductTable">
		<thead>
			<tr>
				<th>주문 상품</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${cartList }" var="cart">
				<tr>
					<td>image</td>
					<td>
						[${cart.BRANDTITLE }] ${cart.TITLE }
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
</body>
</html>