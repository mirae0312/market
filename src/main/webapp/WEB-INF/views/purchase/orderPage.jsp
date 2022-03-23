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
<style>
.tit{
	overflow: hidden;
    width: 1050px;
    margin: 0 auto;
    padding: 50px 0 51px;
}
.tit h2{
    font-weight: 700;
    font-size: 28px;
    color: #333;
    line-height: 35px;
    text-align: center;
    letter-spacing: -1px;
}
table{
	width: 100%;
	padding-top: 50px
}
table, td, th{
	border: 2px solid black;
	border-collapse: collapse;
}
.userInfoTbl, .deliveryTbl, .couponTbl, .paymentTbl{
	padding-top: 74px;
}
.couponTbl, .paymentTbl{
    float: left;
    width: 742px;
}
th{
    text-align: left;
    font-size: 20px;
    padding-bottom: 16px;
}
.p_price{
	text-align: end;
}
.original_price{
	padding-left: 6px;
    font-size: 14px;
    color: #999;
    line-height: 20px;
    word-break: break-all;
    text-decoration: line-through;
    vertical-align: 1px;
    display: block;
    padding-top: 4px;
    line-height: 24px;
    text-align: right;
}
.p_title{
    width: 50%;
}
.p_count{
    width: 20%;
    text-align: end;
}
</style>
	<div class="tit">
		<h2>주문서</h2>
	</div>
	<div class="main">
		<div class="productTbl">
			<table>
				<thead>
					<tr>
						<th colspan="4">주문상품</th>
					</tr>
				</thead>
				<tbody>
				<tr>
					<c:forEach items="${cartList}" var="product">
						<tr>
							<td>image</td>
							<td class="p_title">${product.P_CODE }</td>
							<td class="p_count">${product.COUNT }개</td>
							<td class="p_price">
							<!-- 할인율 있으면  -->
                       	 	<c:if test="${product.DISCOUNT_RATE != null }">
                              <span id="${product.P_CODE }_amount" class="discount_price"> <fmt:formatNumber
                                    type="number" pattern="#########"
                                    value="${Integer.parseInt(product.PRICE)/100 * (100 - Integer.parseInt(product.DISCOUNT_RATE)) * Integer.parseInt(product.COUNT)} " />
                                 원
                              </span>
                              <br />
                               <span id="${product.P_CODE }_ogp" class="original_price"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                       		</span>
                           </c:if> 
                           <c:if test="${product.DISCOUNT_RATE == null }">
                            <span id="${product.P_CODE }_ogp"> <fmt:formatNumber
                                 type="number" pattern="#########"
                                 value="${Integer.parseInt(product.PRICE) * Integer.parseInt(product.COUNT) }" />
                              원
                       		</span>
                           </c:if>
                          
                           </td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="userInfoTbl">
			<table>
				<thead>
					<tr>
						<th colspan="2">주문자 정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>보내는 분</td>
						<td>희연</td>
					</tr>
					<tr>
						<td>휴대폰</td>
						<td>010-2144-3418</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>sp5na92@gmail.com</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="deliveryTbl">
			<table>
				<thead>
					<tr>
						<th colspan="2">배송 정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>배송지</td>
						<td>경기도 성남시 어쩌구</td>
					</tr>
					<tr>
						<td>상세 정보</td>
						<td>문 앞에 배달해주세용~</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="absolute">
			<div class="total_price">
				<h2>결제금액</h2>
				
			</div>
		</div>
		<div class="couponTbl">
			<table>
				<thead>
					<tr>
						<th colspan="2">쿠폰 / 적립금</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>쿠폰 적용</td>
						<td>
						<select name="" id="">
							<option value="">1</option>
							<option value="">2</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>적립금 적용</td>
						<td>사용 가능한 적립금이 없습니다.</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="paymentTbl">
		<table>
			<thead>
				<tr>
					<th colspan="5">결제 수단</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>결제 수단</td>
					<td>
					<input type="radio" /><label for="">카카오 페이</label>
					<input type="radio" /><label for="">신용카드</label>
					<input type="radio" /><label for="">간편결제</label>
					<input type="radio" /><label for="">휴대폰</label>
					</td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
	<div class="test" style="clear: both;"></div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />