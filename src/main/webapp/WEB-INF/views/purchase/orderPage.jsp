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
.title{
	overflow: hidden;
    width: 1050px;
    margin: 0 auto;
    padding: 50px 0 51px;
}
.title h2{
    font-weight: 700;
    font-size: 28px;
    color: #333;
    line-height: 35px;
    text-align: center;
    letter-spacing: -1px;
}
table{
	width: 100%;
}
/* table, td, th{
	border: 2px solid black;
	border-collapse: collapse;
} */
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
        border-bottom: 1px solid black;
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
.submit_btn{
    display: block;
    width: 240px;
    height: 56px;
    margin: 40px auto 0;
    padding-bottom: 2px;
    border: 0 none;
    border-radius: 3px;
    background-color: #5f0080;
    font-weight: 700;
    font-size: 16px;
    color: #fff;
}
.side_bar{
	position: relative;
    float: right;
    width: 284px;
    height: 0;
}
.total_price h2{
    padding: 74px 0 16px;
    font-weight: bold;
    font-size: 20px;
    color: #333;
    line-height: 29px;
    clear: both;
}
th{
	padding-top: 20px;
}
td{
	padding: 20px;
}
.tbl_sub{
	width: 190px;
    padding: 8px 0 0;
    color: #333;
    line-height: 24px;
    letter-spacing: -0.32px;
}
.kakaoPay, .creditCard, .simplePay, .phonePay{
	padding-bottom: 20px;
}
.productTbl thead{
	position: relative;
}
#slide_btn{
	overflow: hidden;
    position: absolute;
    right: 4px;
    background-color: transparent;
    border: none;
    width: 30px;
}
.productTbl tbody {
    display: none;
}
dt{
    float: left;
}
dd{
    float: right;
    text-align: right;
}
dl{
	padding: 20px;
}
#money_info{
    width: 100%;
    padding: 17px 16px 18px 18px;
    background: #fafafa;
    border: 1px solid #f2f2f2;
}
#guide{
    margin: 0 auto;
    text-align: center;
    padding-top: 50px;
}
#slide_btn{
	cursor: pointer;
}
textarea{
	resize: none;
	width: 80%;
	height: 60px;
}
</style>
	<div class="title">
		<h2>주문서</h2>
	</div>
	<div class="main">
		<form action="">
			<div class="productTbl">
				<table>
					<thead>
						<tr>
							<th colspan="4">주문상품
							<button id="slide_btn" type="button">
							<div><img class="slide_img" src="https://res.kurly.com/pc/service/cart/2007/ico_dropup.svg" style="transform: rotate(180deg);" alt="" /></div>
							</button>
						</th>
						</tr>
					</thead>
					<tbody class="cart_slide">
					<tr >
						<c:forEach items="${cartList}" var="product">
							<tr>
								<td class="tbl_sub">image</td>
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
				<div class="order_guide">
				<c:choose>
					<c:when test="${fn:length(cartList) == 1}">
						<p id="guide">${cartList[0].P_CODE} 상품을 주문합니다.</p>
					</c:when>
					<c:otherwise>
						<p id="guide">${cartList[0].P_CODE} 외 ${fn:length(cartList)-1}개 상품을 주문합니다.</p>
					</c:otherwise>
				</c:choose>
				</div>
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
							<td class="tbl_sub">받는 분</td>
							<td>${address.RECEIVER}</td>
						</tr>
						<tr>
							<td class="tbl_sub">휴대폰</td>
							<td>${fn:substring(address.PHONE, 0,3)}-${fn:substring(address.PHONE, 3,7)}-${fn:substring(address.PHONE, 7,11)}
							</td>
						</tr>
						<!-- <tr>
							<td class="tbl_sub">이메일</td>
							<td>sp5na92@gmail.com</td>
						</tr> -->
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
							<td class="tbl_sub">배송지</td>
							<td>${address.ADDRESS} ${address.DETAIL_ADDRESS }</td>
						</tr>
						<tr>
							<td class="tbl_sub">요청 사항</td>
							<td><textarea name="" id="" cols="30" rows="10"></textarea></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="side_bar">
				<div class="total_price">
					<h2>결제금액</h2>
				<div id="money_info">
					<dl class="amount fst">
						<dt class="tit">주문금액</dt>
						<dd class="price">
							<span id="discount_price">0</span> 원
						</dd>
					</dl>
					<dl class="amount sub">
						<dt class="tit">상품금액</dt>
						<dd class="price">
							<span id="original_price">0</span> 원
						</dd>
					</dl>
					<dl class="amount sub">
						<dt class="tit">상품할인금액</dt>
						<dd class="sale">
							<span class="minus">-</span>
							<span>0</span> 원
						</dd>
					</dl>
					<dl class="amount">
						<dt class="tit">배송비</dt>
						<dd class="price delivery_area">
							<div id="delivery" style="display: block;">
								<span class="">0</span> 
							</div>
						</dd>
					</dl>
					<dl class="amount">
						<dt class="tit">쿠폰할인금액</dt>
						<dd class="price coupon_area">
							<span class="minus">-</span> <span
								id="apr_coupon_data">0</span> 원 
						</dd>
					</dl>
					<dl class="amount">
						<dt class="tit">적립금사용</dt>
						<dd class="price">
							<span class="minus">-</span>
							<span class="point" id="point">0 원</span>
						</dd>
					</dl>
					<dl class="amount lst">
						<dt class="tit">최종결제금액</dt>
						<dd class="price">
							<span id="amount">0</span> <span class="won">원</span>
						</dd>
					</dl>
					<!-- <p class="reserve" style="display: block;">
						<span class="ico">적립</span> 구매 시 <span class="emph"><span
							id="expectAmount">426</span> 원 (<span class="ratio">5</span>%) 적립</span>
					</p> -->
				</div>
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
							<td class="tbl_sub">쿠폰 적용</td>
							<td>
							<select name="" id="">
								<option value="">1</option>
								<option value="">2</option>
							</select>
							</td>
						</tr>
						<tr>
							<td class="tbl_sub">적립금 적용</td>
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
						<td class="tbl_sub">결제 수단</td>
						<td>
						<div class="kakaoPay">
							<label class="p_radio"><input type="radio" name="payment">카카오 페이</label>			
						</div>
						<div class="creditCard">
							<label  class="p_radio"><input type="radio" name="payment"/>신용카드</label>						
						</div>
						<div class="simplePay">
							<label class="p_radio" ><input type="radio" name="payment"/>간편결제</label>						
						</div>
						<div class="phonePay">
							<label  class="p_radio"><input type="radio" name="payment"/>휴대폰</label>						
						</div>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
			<div class="test" style="clear: both;"></div>
			<button type="submit" class="submit_btn">원 결제하기</button>
		</form>
	</div>
	<div class="test" style="clear: both;"></div>
<script>
	$("#slide_btn").click((e) => {
		if($(".cart_slide").is(":visible")){
			$(".cart_slide").hide();
			$(".order_guide").show();
			$(".slide_img").css("transform", "rotate(180deg)");
		}
		else{
			$(".cart_slide").show();
			$(".order_guide").hide();
			$(".slide_img").css("transform", "none");
		}
	});
	
	function popup(){
	    var url = '${pageContext.request.contextPath}/purchase/deliveryDetail';
	    var name = "popup test";
	    var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	    window.open(url, name, option);
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />