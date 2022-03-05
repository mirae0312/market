<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productList</title>
</head>
<body>
	<span>상품리스트</span>
	
	<table id="pdtList">
		<thead>
			<tr>
				<th>사진</th>
				<th>브랜드</th>
				<th>title</th>
				<th>원가격</th>
				<th>할인율</th>
				<th>판매가(할인적용)</th>
				<th>subTitle</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${pdtList }" var="product" varStatus="vs">
				<tr>
					<td></td>
					<td>
						${product.brandTitle }
					</td>
					<td>
						<a href="${pageContext.request.contextPath }/product/productDetail?pcode=${product.pcode}">
							${product.title }
						</a>
					</td>
					<td><fmt:formatNumber type="number" pattern="###,###,###" value="${product.price }"/>원</td>
					<td>${product.discountRate }%</td>
					<td><fmt:formatNumber type="number" pattern="###,###,###" value="${product.price/100 * (100 - product.discountRate)} "/>원</td>
					<td>${product.subTitle }</td>
				</tr>
			</c:forEach>
		</tbody>
	
	</table>
</body>
</html>