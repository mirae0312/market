<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="상세페이지" name="title"/>
</jsp:include>
	<h1>상품상세화면입니다.</h1>
	
	<span>${product.title }</span>
	<br />
	<span>${product.subTitle }</span>
	<hr />
	<br />
	<span><fmt:formatNumber type="number" pattern="#########" value="${product.price/100 * (100 - product.discountRate)} "/>원</span>
	<span>할인율 : ${product.discountRate }%</span>
	<br />
	<span>${product.price }</span>
	<hr />
	<br />
	<c:if test="${product.salesUnit != null }">
	<span>판매단위 : ${product.salesUnit }</span>
	<br />
	</c:if>
	<c:if test="${product.weightCapacity != null }">
	<span>중량/용량 : ${product.weightCapacity }</span>
	<hr />
	<br />
	</c:if>
	<c:if test="${prorduct.deliveryDiv != null }">
	<span>배송구분 : ${product.deliveryDiv }</span>
	<hr />
	<br />
	</c:if>
	<c:if test="${product.origin != null }">
	<span>원산지 : ${product.origin }</span>
	<hr />
	<br />
	</c:if>
	<c:if test="${product.packType != null }">
	<span>포장타입 : ${product.packType }</span>
	<span>${product.packTypeSub }</span>
	<hr />
	<br />
	</c:if>
	<c:if test="${product.expiration != null }">
	<span>유통기한 : ${product.expiration }</span>
	<hr />
	<br />
	</c:if>
	<c:if test="${product.allergyInfo != null }">
	<span>알러지정보 : ${product.allergyInfo }</span>
	<hr />
	<br />
	</c:if>
	<c:if test="${product.sugar != null }">
	<span>당도 : ${product.sugar }</span>
	<hr />
	<br />
	</c:if>
	<c:if test="${product.livestockInfo != null }">
	<span>축산물정보 : ${product.livestockInfo }</span>
	<hr />
	<br />
	</c:if>
	<c:if test="${product.commonInfo != null }">
	<span>안내사항 : ${product.commonInfo }</span>
	<hr />
	</c:if>
	<span>구매 수량</span>
	<input type="button" value="-" id="countMinus"/>
	<input type="text" name="" id="pdtCount" value="1" readonly/>
	<input type="button" value="+" id="countPlus"/>
	<br />
	<br />
	<hr />
	<span>
		총 상품금액 : 
		<span id="finalPrice">
		<fmt:formatNumber type="number" pattern="########" value="${product.price/100 * (100 - product.discountRate)} "/>
		원
		</span>
	</span>
	<br />
	<br />
	<input type="button" value="addWishList" id="addWishList" />
	<input type="button" value="notifyBtn" id="notify"/>
	<input type="button" value="장바구니 담기" id="addCart" />
	
	<script>
		/* 구매수량 -> 상품금액 반영 script */
		$("#countMinus").click((e) => {
			let price = ${product.price/100 * (100 - product.discountRate)} * 1;
			let num = $("#pdtCount").val() * 1;
			if(num != 1){
				$("#pdtCount").val(num-1);	
				$("#finalPrice").text(price * $("#pdtCount").val()+ '원');
			}
		});
		$("#countPlus").click((e) => {
			let price = ${product.price/100 * (100 - product.discountRate)} * 1;
			let num = $("#pdtCount").val() * 1;
			$("#pdtCount").val(num+1);
			$("#finalPrice").text(price * $("#pdtCount").val()+ '원');
		});
		
		/* 장바구니 담기 스크립트 */
		$("#addCart").click((e) => {
			const pcode = '${product.pcode}';
			const count = $("#pdtCount").val();
			$.ajax({
				url: '${pageContext.request.contextPath}/product/addCart?${_csrf.parameterName}=${_csrf.token}',
				method: 'POST',
				data:{
					pcode,
					count
				},
				success(res){
					alert(res);
				},
				error: console.log
			})
		});
	
	</script>
</body>
</html>