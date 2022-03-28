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
<sec:authentication property="principal" var="loginMember"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/purchase/orderComplete.css" /> 
<div class="order-container">
	<div class="section-end">
		<div class="order-result">
			<div class="delivery_check">
				<img src="https://res.kurly.com/mobile/service/order/1909/img_success_order_end.gif" alt="아이콘" class="ico">
				<div class="check">
					<p class="tit">
					<span id="user_name" class="name">장희연님의</span>
					<span id="completed" class="name">주문이 완료되었습니다.</span>
					</p>
					<strong id="delivery_complete_message">내일 아침에 만나요!</strong>
				</div>
			</div>
			<div class="amount_money ">
				<ul>
					<li>
					<span class="title">결제금액</span>
					<strong class="money">2,900 <span class="won">원</span></strong>
					</li>
					<li>
					<span class="title">적립금</span>
					<span class="amount">+0 원</span>
					</li>
				</ul>
			</div>
			<div class="button_group">
				<button type="button" id="white_btn">주문 상세보기</button>
				<button type="button" id="purple_btn" onclick="location.href='${pageContext.request.contextPath}'">쇼핑 계속하기</button>
			</div>
		</div>	
	</div>
	
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />